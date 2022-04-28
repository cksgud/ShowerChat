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
    @Binding var ip_address: String
//    var player = AVPlayer(url:  URL(string: "http://192.168.10.107:8080/hello/playlist.m3u8")!)
//    var player = AVPlayer(url:  URL(string: SharedRepo.sharedVariables.liveInvitationCode)!)
    let profileData = ProfileData.all()
    
    var body: some View {
        if goToView == "mainview" {
            MainView()
        } else {
            ZStack {
                if ip_address != "" {
                    var player = AVPlayer(url:  URL(string: ip_address)!)
                    VideoPlayer(player: player)
                        .scaleEffect(x: 4, y: 4, anchor: .center)
                        .onAppear(perform: {
                            player.play()
                        })
                } else {
                    LiveVideo()
                        .scaleEffect(x: 1.7, y: 1.7, anchor: .center)
                        .edgesIgnoringSafeArea(.all)
                }
                    
                VStack {
                    HStack {
                        Text("Live 1:03:50")
                            .foregroundColor(.white)
                            .background(Color(red: 237 / 255, green: 86 / 255, blue: 86 / 255))
                        HStack {
                            Image(systemName: "person.fill")
                                .resizable()
                                .frame(width: 14, height: 14)
                            Text("1,900")
                        }
                        .foregroundColor(Color(red: 73 / 255, green: 70 / 255, blue: 70 / 255))
                        .overlay(
                            RoundedRectangle(cornerRadius: 1)
                                .stroke(Color(red: 73 / 255, green: 70 / 255, blue: 70 / 255), lineWidth: 1)
                        )
                        Spacer()
                        Button(action: {
                            goToView = "mainview"
                            SharedRepo.sharedVariables.liveInvitationCode.removeAll()
//                            player.pause()
                        }) {
                            Image("icClose")
                                .frame(width:24, height: 24)
                                .padding(.trailing, 24)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.top, 63)
                    .padding(.leading, 28)
                    
                    HStack{
                        Image("liveProfile")
                            .resizable()
                            .frame(width:38, height: 38)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        VStack(alignment: .leading) {
                            Text("착한사람을 그만두면 인생이 편해진다")
                                .font(Font.custom("AppleSDGothicNeo-Bold", size: 17))
                                .padding(.leading, 12)
                                .foregroundColor(.white)
                            Text("곽정은 멘토")
                                .font(Font.custom("AppleSDGothicNeo-Light", size: 12))
                                .padding(.leading, 12)
                                .foregroundColor(.white)
                        }
                        Spacer()
                    }
                    .padding(.leading, 28)
                    ScrollView {
                        VStack {
                            HStack {
                                Text("Sara**")
                                    .font(Font.custom("AppleSDGothicNeo-Light", size: 14))
                                    .padding(.leading, 18)
                                    .foregroundColor(.black)
                                
                                Text("거절 잘하는 방법이 궁금해요")
                                    .font(Font.custom("AppleSDGothicNeo-Light", size: 14))
                                    .padding(.leading, 22)
                                    .foregroundColor(.black)
                                
                                Spacer()
                            }
                            
                            if !liveChattingText.isEmpty {
                                ForEach(liveChattingText, id:\.self ) { liveChattingText in
                                    HStack {
                                        Text("Dani**")
                                            .font(Font.custom("AppleSDGothicNeo-Light", size: 14))
                                            .padding(.leading, 18)
                                            .foregroundColor(.black)
                                        
                                        Text(liveChattingText)
                                            .font(Font.custom("AppleSDGothicNeo-Light", size: 14))
                                            .padding(.leading, 22)
                                            .foregroundColor(.black)
                                        
                                        Spacer()
                                    }
                                }
                            }
                        }
                    }
                    Spacer()
                    LiveChatUserTextField(liveChattingText: $liveChattingText)
                }
                .edgesIgnoringSafeArea(.all)
                .padding(.bottom, 1)
            }
        }
    }
}
