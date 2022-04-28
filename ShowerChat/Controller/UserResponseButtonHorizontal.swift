//
//  ResponseButton.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/09/05.
//

import SwiftUI

struct UserResponseButtonHorizontal: View {
    @EnvironmentObject private var clientSocket: Connection
    @State var foregroundColor = Color.white
    @State var backgroundColor = Color.black.opacity(0.2)
    @State var opacityOnAppear : Double = 0
    let userResponse: String
    #if PROTOCOL_SERVER
    let responseType: String
    #endif
    @Binding var selectionMentalCare: String?
    @Binding var goNext: Bool
    
    var body: some View {
        Button(action: {
            backgroundColor = .white
            foregroundColor = .black
            SharedRepo.sharedVariables.onAppearNumber = 1.0
            if userResponse.contains("명상") {
                VideoRepo.sharedVideos.smartVideoPlayer.queuePlayer.pause()
                self.selectionMentalCare = "meditation"
            } else if userResponse.contains("대화 종료") {
                VideoRepo.sharedVideos.smartVideoPlayer.queuePlayer.pause()
                self.selectionMentalCare = "afterchat"
            } else if userResponse.contains("일기") {
                playNextSmartly(goNext: $goNext)
                #if PROTOCOL_LOCAL
                actionForButton(userResponse: userResponse, clientSocket: clientSocket)
                #else
                actionForButton(userResponse: userResponse, responseType: responseType, clientSocket: clientSocket)
                #endif
            } else if userResponse.contains("Better") {
                VideoRepo.sharedVideos.smartVideoPlayer.queuePlayer.pause()
                #if PROTOCOL_LOCAL
                actionForButton(userResponse: userResponse, clientSocket: clientSocket)
                #else
                actionForButton(userResponse: userResponse, responseType: responseType, clientSocket: clientSocket)
                #endif
            } else {//명상하러 가기 버튼 누른 후 되돌아올 시 예외처리
                playNextSmartly(goNext: $goNext)
                #if PROTOCOL_LOCAL
                actionForButton(userResponse: userResponse, clientSocket: clientSocket)
                #else
                actionForButton(userResponse: userResponse, responseType: responseType, clientSocket: clientSocket)
                #endif
            }
        }) {
            #if PROTOCOL_LOCAL
            if userResponse.contains("▶") {
                MusicButton(imageName: "albumIcon", musicName: "Better Together", artistName: "Pate Jonas")
            } else {
                ResponseButtonText(userResponse: userResponse)
            }
            #elseif PROTOCOL_SERVER
            if responseType.contains("music") {
                MusicButton(imageName: "albumIcon", musicName: "Better Together", artistName: "Pate Jonas")
            } else {
                ResponseButtonText(userResponse: userResponse)
            }
            #endif
        }
        .frame(width: 80, height: 100)
        .foregroundColor(foregroundColor)
        .padding(.all)
        .background(backgroundColor)
        .cornerRadius(17)
        .overlay(
            RoundedRectangle(cornerRadius: 17)
//                .stroke(Color(red: 153 / 255, green: 153 / 255, blue: 154 / 255), lineWidth: 1)
                .stroke(Color.white, lineWidth: 1)
        )
        .multilineTextAlignment(.center)
        .opacity(opacityOnAppear)
        .onAppear() {
            SharedRepo.sharedVariables.onAppearNumber -= 0.2
            DispatchQueue.main.asyncAfter(deadline: .now() + SharedRepo.sharedVariables.onAppearNumber, execute: {
                withAnimation(.easeIn(duration: 1.0)) {
                    opacityOnAppear = 1.0
                }
            })
        }
        .animation(.easeIn)
        .transition(.move(edge: .bottom))
    }
}
