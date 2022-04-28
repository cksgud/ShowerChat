//
//  ChatScreen.swift
//  SwiftChat
//
//  Created by 김찬형 on 2021/07/28.
//

import SwiftUI
import AVKit

struct ChatScreen: View {
    let profileData = ProfileData.all()
    @ObservedObject var sharedVariables = SharedRepo.sharedVariables
    
    @EnvironmentObject private var clientSocket: Connection
    @State private var isPresented = true
    @State private var selectionMentalCare: String?
    @State var goNext = false
    
    let topPadding = UIApplication.shared.keyWindow!.safeAreaInsets.top
    let bottomPadding = UIApplication.shared.keyWindow!.safeAreaInsets.bottom
    
#if PROTOCOL_LOCAL
    let chatBotAnswerData = ChatBotAnswerData.all()
    let userResponseData = UserResponseData.all()
#endif
    
    var body: some View {
        if selectionMentalCare == "meditation" {
            MeditationView()
        } else if selectionMentalCare == "mainview" {
            MainView()
        } else {
            ZStack {
                MentalVideosPlayer(goNext: $goNext)
                    .scaleEffect(x: 1.3, y: 1.3, anchor: .center)
                VStack {
                    HStack {
                        Image("imgProfile")
                            .resizable()
                            .frame(width:38, height: 38)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .padding(.leading, 24)
                        Text("Melissa")
                            .font(Font.custom("AppleSDGothicNeo-Bold", size: 22))
                            .padding(.leading, 12)
                            .foregroundColor(.white)
                        Spacer()
                        Button(action: {
                            selectionMentalCare = "mainview"
                            SharedRepo.sharedVariables.mentalVideoPlayer.queuePlayer.pause()
                        }) {
                            Image("icClose")
                                .frame(width:24, height: 24)
                                .padding(.trailing, 24)
                                .foregroundColor(.white)
                        }
                    }
//                    .padding(.top, 55 - topPadding)
                    
                    Spacer()
                    
                    #if PROTOCOL_LOCAL
                    if sharedVariables.isShowOn {
                        ChatBotAnswerTextView(chatBotAnswer: sharedVariables.chatbot)
                            .padding(.bottom, 29)
                        
                        if sharedVariables.usrRespBtnHorizontal {
                            if sharedVariables.response_type.contains("music") {
                                MusicPlayer(goNext: $goNext)
                            } else if sharedVariables.response_type.contains("diary") {
                                Diary(goNext: $goNext)
                            } else {
                                HStack {
                                    ForEach(sharedVariables.user_response_data, id:\.self ) { userResponse in
                                        UserResponseButtonHorizontal(userResponse: userResponse, selectionMentalCare: $selectionMentalCare, goNext: $goNext)
                                    }
                                }
                            }

                        } else {
                            if sharedVariables.response_type.contains("music") {
                                MusicPlayer(goNext: $goNext)
                            } else if sharedVariables.response_type.contains("diary") {
                                Diary(goNext: $goNext)
                            } else {
                                VStack {
                                    ForEach(sharedVariables.user_response_data, id:\.self ) { userResponse in
                                        UserResponseButtonVertical(userResponse: userResponse, selectionMentalCare: $selectionMentalCare, goNext: $goNext)
                                    }
                                }
                            }
                        }
                    }

                    #elseif PROTOCOL_SERVER
                    if sharedVariables.isShowOn {
                        ChatBotAnswerTextView(chatBotAnswer: sharedVariables.chatbot)
                            .padding(.bottom, 29)
                        
                        if sharedVariables.usrRespBtnHorizontal {
                            if sharedVariables.musicPlayerOn {
                                MusicPlayer(goNext: $goNext)
                            } else if sharedVariables.onelineDiaryOn {
                                Diary(goNext: $goNext)
                            } else {
                                HStack {
                                    ForEach(0 ..< sharedVariables.user_response.count, id:\.self ) { rspNum in
                                        UserResponseButtonHorizontal(userResponse: sharedVariables.user_response[rspNum], responseType: sharedVariables.response_type[rspNum], selectionMentalCare: $selectionMentalCare, goNext: $goNext)
                                    }
                                }
                            }
                        } else {
                            if sharedVariables.musicPlayerOn {
                                MusicPlayer(goNext: $goNext)
                            } else if sharedVariables.onelineDiaryOn {
                                Diary(goNext: $goNext)
                            } else {
                                VStack {
                                    ForEach(0 ..< sharedVariables.user_response.count, id:\.self ) { rspNum in
                                        UserResponseButtonVertical(userResponse: sharedVariables.user_response[rspNum], responseType: sharedVariables.response_type[rspNum], selectionMentalCare: $selectionMentalCare, goNext: $goNext)
                                    }
                                }
                            }
                        }
                    }
                    #endif
                }
                .edgesIgnoringSafeArea(.bottom)
                .padding(.bottom, 35 - bottomPadding)
            }
            .onAppear(perform: {
                SharedRepo.sharedVariables.mentalVideoPlayer.queuePlayer.play()
                #if PROTOCOL_LOCAL
                clientSocket.connect(ip: "192.168.10.102", port: 8000)
                #else
                clientSocket.connect(ip: "34.127.68.142", port: 8008)
                #endif
                 
                #if PROTOCOL_LOCAL
                if sharedVariables.user_response_data.isEmpty {//화면 재진입 시 버그 해결
                    sharedVariables.chatbot = chatBotAnswerData[sharedVariables.chatbot_answer_count].answer
                    if sharedVariables.user_response_count == 0 {//명상하러 가기 버튼 누른 후 되돌아올 시 예외처리
                        for userResponse in 0 ..< userResponseData[0].responses.count {
                            sharedVariables.user_response_data.append(userResponseData[0].responses[userResponse])
                        }
                    }
                    if userResponseData[0].responses.count > 2 {
                        sharedVariables.usrRespBtnHorizontal = true
                    } else {
                        sharedVariables.usrRespBtnHorizontal = false
                    }
                }
                #endif
            })
            .onChange(of: sharedVariables.user_response_count, perform: { user_response_count in
                #if PROTOCOL_LOCAL
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                    SharedRepo.sharedVariables.isShowOn.toggle()
                    sharedVariables.user_response_data.removeAll()
                    if sharedVariables.user_response_picked.contains("▶") {
                        sharedVariables.response_type.append("music")
                    } else if sharedVariables.user_response_picked.contains("일기") {
                        sharedVariables.response_type.append("diary")
                    } else {
                        for userResponse in 0 ..< userResponseData[user_response_count].responses.count {
                            sharedVariables.user_response_data.append(userResponseData[user_response_count].responses[userResponse])
                        }
                    }
                    
                    if userResponseData[user_response_count].responses.count > 2 {
                        sharedVariables.usrRespBtnHorizontal = true
                    } else {
                        sharedVariables.usrRespBtnHorizontal = false
                    }
                    sharedVariables.chatbot_answer_count += 1
                    sharedVariables.chatbot = chatBotAnswerData[sharedVariables.chatbot_answer_count].answer
                }
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    SharedRepo.sharedVariables.isShowOn.toggle()
                }
                #elseif PROTOCOL_SERVER
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                    sharedVariables.chatbot.removeAll()
                    sharedVariables.user_response.removeAll()
                }
                #endif
            })
        }
    }
}
