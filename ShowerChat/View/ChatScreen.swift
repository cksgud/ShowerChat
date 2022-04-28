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
    
    let chatBotAnswerData = ChatBotAnswerData.all()
    let userResponseData = UserResponseData.all()
    
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
                    if sharedVariables.usrRspBtnVisible {
                        TestTextView(answer: sharedVariables.responses.count > 0 ? sharedVariables.responses[0] : chatBotAnswerData[sharedVariables.ansNum].answer)
                    }

                    HStack {
                        if sharedVariables.usrRspBtnVisible {
                            TestButton(response: sharedVariables.responses.count > 0 ? sharedVariables.responses[1] : userResponseData[sharedVariables.btnNum1].response)
                            TestButton(response: sharedVariables.responses.count > 0 ? sharedVariables.responses[2] : userResponseData[sharedVariables.btnNum2].response)
                            TestButton(response: sharedVariables.responses.count > 0 ? sharedVariables.responses[3] : userResponseData[sharedVariables.btnNum3].response)
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
