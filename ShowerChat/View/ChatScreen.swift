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
    
    var body: some View {
        ZStack {
            VideoPlayer(player: player)
                .onAppear() {
                    player.play()
                }
                .onChange(of: sharedVariables.isPlayOn, perform: { isPlayOn in
                    isPlayOn ? player.play() : player.pause()
                })
            
            VStack {
                Spacer()
                
                HStack {
                    CircleButton(buttonImage: "music.note")
                    Spacer()
                }
                
                HStack {
                    CircleButton(buttonImage: "music.note")
                    Spacer()
                }
                .offset(y:-25)
                
                Spacer()
                Spacer()
                
                VStack {
                    if sharedVariables.usrRspBtnVisible {
                        ChatBotAnswerTextView(chatBotAnswerData: chatBotAnswerData[sharedVariables.ansNum])
                    } else {
                        ChatBotAnswerTextView(chatBotAnswerData: chatBotAnswerData[sharedVariables.ansNum]).hidden()
                    }
                    
                    Divider()
                    
                    HStack {
                        ForEach(self.userResponseData, id:\.response ) { userResponseData in
                            if sharedVariables.usrRspBtnVisible {
                                UserResponseButton(userResponseData: userResponseData)
                            } else {
                                UserResponseButton(userResponseData: userResponseData).hidden()
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ChatScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChatScreen()
    }
}
