//
//  MeditationView.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/09/29.
//

import SwiftUI
import AVKit

struct MeditationView: View {
    var player = AVPlayer(url:  Bundle.main.url(forResource: "Meditation_Report_Background", withExtension: "mp4")!)
    var chatbotPlayer = AVPlayer(url:  Bundle.main.url(forResource: "mentalcare_01_14", withExtension: "mp4")!)
    @State private var foregroundColor = Color.white
    @State private var backgroundColor = Color.black.opacity(0.2)
    @State private var selectionMentalCare: String?
    
//    let topPadding = UIApplication.shared.keyWindow!.safeAreaInsets.top
    let bottomPadding = UIApplication.shared.keyWindow!.safeAreaInsets.bottom
    
    var body: some View {
        if selectionMentalCare == "chatscreen" {
            ChatScreen().environmentObject(Connection())
        } else if selectionMentalCare == "afterchat" {
            AfterChatView()
        } else if selectionMentalCare == "mainview" {
            MainView()
        } else {
            ZStack {
                AVPlayerView(player: player)
                    .scaleEffect(x: 1.5, y: 1.5, anchor: .center)
                VStack {
                    HStack {
                        Button(action: {
                            selectionMentalCare = "chatscreen"
                            SharedRepo.sharedVariables.usrRespBtnHorizontal = false
                            chatbotPlayer.pause()
                        }) {
                            Image(systemName: "chevron.backward")
                                .font(.system(size: 28, weight: .light))
                        }
                        .padding(.leading, 20)
                        Spacer()
                        Text("5분 명상하기")
                            .font(Font.custom("AppleSDGothicNeo-Bold", size: 24))
                        Spacer()
                        Button(action: {
                            selectionMentalCare = "mainview"
                            VideoRepo.sharedVideos.smartVideoPlayer.queuePlayer.pause()
                        }) {
                            Image("icClose")
                        }
                        .padding(.trailing, 27)
                    }
                    .foregroundColor(.white)
                    .padding(.top, 60)
                    
//                    Spacer()
                    
                    Text("⏱ 05:00")
                        .foregroundColor(.white)
                        .font(Font.custom("GujaratiMT", size: 40))
                        .padding(.top, 88)
                        .padding(.bottom, 50)
                    Text("""
                        5분간 명상을 하면
                        하루 기분에 도움이 많이 돼요

                        지금부터 명상을 시작해볼게요
                        방에 조도를 낮추고
                        편안한 자세로 앉아 주세요.

                        숨을 깊게 들이 마시고
                        잠시 멈추었다
                        다시 숨을 내쉬어 보세요
                        """)
                        .multilineTextAlignment(.center)
                        .lineSpacing(12)
                        .font(Font.custom("AppleSDGothicNeo-Light", size: 18))
                        .foregroundColor(.white)
                        .frame(width: 217)
                    
                    Spacer()
                    
                    Button(action: {
                        backgroundColor = .white
                        foregroundColor = .black
                        selectionMentalCare = "afterchat"
                        VideoRepo.sharedVideos.smartVideoPlayer.queuePlayer.pause()
                        chatbotPlayer.pause()
                        SharedRepo.sharedVariables.meditationDone = true
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                            withAnimation(.easeIn(duration: 1.0)) {
                                backgroundColor = Color.black.opacity(0.3)
                                foregroundColor = .white
                            }
                        })
                    }) {
                        Text("명상 끝내기")
                            .font(Font.custom("AppleSDGothicNeo", size: 16))
                    }
                    .frame(width: 300, height: 40)
                    .foregroundColor(foregroundColor)
                    .padding(.all)
                    .background(backgroundColor)
                    .cornerRadius(17)
                    .overlay(
                        RoundedRectangle(cornerRadius: 17)
                            .stroke(Color(red: 153 / 255, green: 153 / 255, blue: 154 / 255), lineWidth: 1)
                    )
                    .multilineTextAlignment(.center)
                    .offset(y: -36)
                }
                .padding(.bottom, 36 - bottomPadding)
            }
            .edgesIgnoringSafeArea(.all)
            .onAppear(perform: {
                chatbotPlayer.play()
            })
        }
    }
}
