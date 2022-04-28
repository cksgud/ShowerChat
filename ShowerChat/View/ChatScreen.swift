//
//  ChatScreen.swift
//  SwiftChat
//
//  Created by 김찬형 on 2021/07/28.
//

import SwiftUI
import AVKit

struct ChatScreen: View {
    var player = AVPlayer(url:  Bundle.main.url(forResource: "mentalCareVideo", withExtension: "MP4")!)
    @ObservedObject var sharedVariables = SharedRepo.sharedVariables
    
    @EnvironmentObject private var clientSocket: Connection
    @State private var isPresented = true
    
    var body: some View {
        ZStack {
            VideoPlayer(player: player)
                .onAppear() {
                    player.play()
                }
                .onChange(of: sharedVariables.isPlayOn, perform: { isPlayOn in
                    isPlayOn ? player.play() : player.pause()
                })
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
            
            VStack {
                Spacer()

                VStack {
                    if sharedVariables.usrRspBtnVisible && !sharedVariables.chatbot.isEmpty {
                        ChatBotAnswerTextView(chatBotAnswer: sharedVariables.chatbot)
                    }

                    HStack {
                        ForEach(sharedVariables.user_response, id:\.self ) { response in
                            if sharedVariables.usrRspBtnVisible {
                                UserResponseButton(userResponse: response)
                            }
                        }
                    }
                }
            }
        }
        .onAppear(perform: {
            clientSocket.connect(ip: "192.168.10.102", port: 8000)
        })
    }
}
