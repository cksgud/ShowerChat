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
    var player = AVPlayer(url:  Bundle.main.url(forResource: "melissaVideo", withExtension: "mp4")!)
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
                AVPlayerView(player: player, isPlayOn: sharedVariables.isPlayOn)
                    .scaleEffect(x: 1.2, y: 1.2, anchor: .center)
    //                .blur(radius: 1, opaque: true)
    //                .ignoresSafeArea(edges: .all)
    //                .aspectRatio(contentMode: .fill)
                VStack {
                    ProfileArea(profileData: profileData[0])
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
                            if sharedVariables.response_type.contains("music") {
                                MusicPlayer()
                            } else if sharedVariables.response_type.contains("diary") {
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
                    if sharedVariables.isShowOn {
                        ChatBotAnswerTextView(chatBotAnswer: sharedVariables.chatbot)
                        
                        if sharedVariables.usrRespBtnHorizontal {
                            if sharedVariables.musicPlayerOn {
                                MusicPlayer()
                            } else if sharedVariables.response_type.contains("diary") {
                                Diary()
                            } else {
                                HStack {
                                    ForEach(0 ..< sharedVariables.user_response.count, id:\.self ) { rspNum in
                                        UserResponseButtonHorizontal(userResponse: sharedVariables.user_response[rspNum], responseType: sharedVariables.response_type[rspNum], selectionMentalCare: $selectionMentalCare)
                                    }
                                }
                            }
                        } else {
                            if sharedVariables.musicPlayerOn {
                                MusicPlayer()
                            } else if sharedVariables.response_type.contains("diary") {
                                Diary()
                            } else {
                                VStack {
                                    ForEach(0 ..< sharedVariables.user_response.count, id:\.self ) { rspNum in
                                        UserResponseButtonVertical(userResponse: sharedVariables.user_response[rspNum], responseType: sharedVariables.response_type[rspNum], selectionMentalCare: $selectionMentalCare)
                                    }
                                }
                            }
                        }
                    }
                    #endif
                }
            }
            .onAppear(perform: {
                #if PROTOCOL_LOCAL
                clientSocket.connect(ip: "192.168.10.102", port: 8000)
                #else
                clientSocket.connect(ip: "192.168.10.102", port: 8008)
                #endif
                 
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
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    sharedVariables.chatbot.removeAll()
                    sharedVariables.user_response.removeAll()
                }
                #endif
            })
        }
    }
}

struct AVPlayerView: UIViewControllerRepresentable {
    var player: AVPlayer
    var isPlayOn: Bool

    func updateUIViewController(_ playerController: AVPlayerViewController, context: Context) {
        playerController.showsPlaybackControls = false
        playerController.modalPresentationStyle = .fullScreen
        playerController.player = player
        
        if isPlayOn {
            playerController.player?.play()
        } else {
            playerController.player?.pause()
        }

    }

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        return AVPlayerViewController()
    }
}
