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
    @ObservedObject var playShared = PlayRepo.playShared
    
    let chatBotAnswerMakers = ChatBotAnswerMaker.all()
    let userResponseMakers = UserResponseMaker.all()
    
    var body: some View {
        ZStack {
            VideoPlayer(player: player)
                .onAppear() {
                    player.play()
                }
                .onChange(of: playShared.isPlayOn, perform: { isPlayOn in
                    isPlayOn ? player.play() : player.pause()
                })
            
            VStack {
                Spacer()
                
                VStack {
                    HStack {
                        CircleButton(buttonImage: "music.note")
                        Spacer()
                    }
                    
                    HStack {
                        CircleButton(buttonImage: "music.note")
                        Spacer()
                    }
                    .offset(y:-25)
                }
                
                Spacer()
                Spacer()
                
                VStack {
                    ChatBotAnswerTextView(answer: chatBotAnswerMakers[0].answer)
                    
                    Divider()
                    
                    HStack {
                        UserResponseButton(response: userResponseMakers[0].response)
                        UserResponseButton(response: userResponseMakers[1].response)
                        UserResponseButton(response: userResponseMakers[2].response)
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
