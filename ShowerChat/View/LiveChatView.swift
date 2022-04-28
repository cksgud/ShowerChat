//
//  LiveChatView.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/10/19.
//

import SwiftUI
import AVKit

struct LiveChatView: View {
    @State private var goToView: String?
    @State var liveChattingText: [String]
    var player = AVPlayer(url:  URL(string: SharedRepo.sharedVariables.liveURL)!)
    let profileData = ProfileData.all()
    
    var body: some View {
        if goToView == "mainview" {
            MainView()
        } else {
            ZStack {
                VideoPlayer(player: player)
                    .scaleEffect(x: 4, y: 4, anchor: .center)
                    .onAppear(perform: {
                        player.play()
                    })
                    
                VStack {
                    HStack {
                        Image("Doctor")
                            .resizable()
                            .frame(width:38, height: 38)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .padding(.leading, 24)
                        Text("라이브 채팅 상담")
                            .font(Font.custom("AppleSDGothicNeo-Bold", size: 22))
                            .padding(.leading, 12)
                            .foregroundColor(.white)
                        Spacer()
                        Button(action: {
                            goToView = "mainview"
                            player.pause()
                        }) {
                            Image("icClose")
                                .frame(width:24, height: 24)
                                .padding(.trailing, 24)
                                .foregroundColor(.white)
                        }
                    }
                    ScrollView {
                        VStack {
                            ChatBubble(direction: .left) {
                                Text("안녕하세요 상담사입니다. 어떻게 도와드릴까요?")
                                    .padding(.all, 10)
                                    .foregroundColor(Color.white)
                                    .background(Color.gray)
                            }
                            if !liveChattingText.isEmpty {
                                ForEach(liveChattingText, id:\.self ) { liveChattingText in
                                    ChatBubble(direction: .right) {
                                        Text(liveChattingText)
                                            .padding(.all, 10)
                                            .foregroundColor(Color.white)
                                            .background(Color.yellow)
                                    }
                                }
                            }
                        }
                    }
                    Spacer()
                    LiveChatUserTextField(liveChattingText: $liveChattingText)
                }
                .edgesIgnoringSafeArea(.bottom)
                .padding(.bottom, 1)
            }
        }
    }
}
