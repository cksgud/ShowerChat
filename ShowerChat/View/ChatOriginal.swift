//
//  ChatOriginal.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/10/01.
//

import SwiftUI

struct ChatOriginal: View {
    let profileData = ProfileData.all()
    @ObservedObject var sharedVariables = SharedRepo.sharedVariables
    
    @EnvironmentObject private var clientSocket: Connection
    @State private var isPresented = true
    @State private var selectionMentalCare: String?
    
#if PROTOCOL_LOCAL
    let chatBotAnswerData = ChatBotAnswerData.all()
    let userResponseData = UserResponseData.all()
#endif
    
    var body: some View {
        if selectionMentalCare == "meditation" {
            MeditationView()
        } else {
            ZStack {
                NavigationLink(destination: MeditationView(), tag:"meditation", selection: $selectionMentalCare) { EmptyView() }
                
                VStack {
                    ProfileArea(profileData: profileData[0])
                        .padding(.top, 55)
                    Divider()
                    ZStack(
                        alignment:Alignment(horizontal: .leading, vertical: .top)
                    ) {
                        Circle()
                            .foregroundColor(.green)
                        Text("Swift Wombat")
                    }
                    Spacer()
                    #if PROTOCOL_LOCAL
                    if sharedVariables.isShowOn {
                        ChatBotAnswerTextView(chatBotAnswer: sharedVariables.chatbot)
                        
                        if sharedVariables.usrRespBtnHorizontal {
                            HStack {
                                ForEach(sharedVariables.user_response_data, id:\.self ) { userResponse in
                                    UserResponseButtonHorizontal(userResponse: userResponse, selectionMentalCare: $selectionMentalCare)
                                }
                            }
                        } else {
                            if sharedVariables.response_type == "music" {
                                MusicPlayer()
                            } else if sharedVariables.response_type == "diary" {
                                Diary()
                            } else {
                                VStack {
                                    ForEach(sharedVariables.user_response_data, id:\.self ) { userResponse in
                                        UserResponseButtonVertical(userResponse: userResponse, selectionMentalCare: $selectionMentalCare)
                                    }
                                }
                            }
                        }
                    }

                    #elseif PROTOCOL_SERVER
//                    ChatBotAnswerTextView(chatBotAnswer: sharedVariables.chatbot)
//                    HStack {
//                        ForEach(sharedVariables.user_response, id:\.self ) { response in
//                            if sharedVariables.usrRspBtnVisible {
//                                UserResponseButtonHorizontal(userResponse: response)
//                            }
//                        }
//                    }
                    if sharedVariables.isShowOn {
                        ChatBotAnswerTextView(chatBotAnswer: sharedVariables.chatbot)
                        
                        if sharedVariables.usrRespBtnHorizontal {
                            HStack {
                                ForEach(sharedVariables.user_response, id:\.self ) { userResponse in
                                    UserResponseButtonHorizontal(userResponse: userResponse, selectionMentalCare: $selectionMentalCare)
                                }
                            }
                        } else {
                            if sharedVariables.response_type == "music" {
                                MusicPlayer()
                            } else if sharedVariables.response_type == "diary" {
                                Diary()
                            } else {
                                VStack {
                                    ForEach(sharedVariables.user_response, id:\.self ) { userResponse in
                                        UserResponseButtonVertical(userResponse: userResponse, selectionMentalCare: $selectionMentalCare)
                                    }
                                }
                            }
                        }
                    }
                    #endif
                }
                .padding(.bottom, 20)
            }
            .onAppear(perform: {
                clientSocket.connect(ip: "192.168.10.102", port: 8000)
                 
                #if PROTOCOL_LOCAL
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
                #endif
            })
            .onChange(of: sharedVariables.user_response_count, perform: { user_response_count in
                #if PROTOCOL_LOCAL
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                    SharedRepo.sharedVariables.isShowOn.toggle()
                    sharedVariables.user_response_data.removeAll()
                    if sharedVariables.user_response_picked.contains("▶") {
                        sharedVariables.response_type = "music"
                    } else if sharedVariables.user_response_picked.contains("일기") {
                        sharedVariables.response_type = "diary"
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
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    sharedVariables.chatbot.removeAll()
                    sharedVariables.user_response.removeAll()
                }
                #endif
            })
            .background(Color.blue)
            .ignoresSafeArea(edges: .all)
        }
    }
}
