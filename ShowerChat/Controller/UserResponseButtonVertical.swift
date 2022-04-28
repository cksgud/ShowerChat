//
//  UserResponseButtonVertical.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/09/28.
//

import SwiftUI
import Foundation

struct UserResponseButtonVertical: View {
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
                self.selectionMentalCare = "meditation"
            } else if userResponse.contains("일기") {
                SharedRepo.sharedVariables.mentalVideoPlayer.queuePlayer.pause()
                #if PROTOCOL_LOCAL
                actionForButton(userResponse: userResponse, clientSocket: clientSocket)
                #else
                actionForButton(userResponse: userResponse, responseType: responseType, clientSocket: clientSocket)
                #endif
            } else if userResponse.contains("Better") {
                SharedRepo.sharedVariables.mentalVideoPlayer.queuePlayer.pause()
                #if PROTOCOL_LOCAL
                actionForButton(userResponse: userResponse, clientSocket: clientSocket)
                #else
                actionForButton(userResponse: userResponse, responseType: responseType, clientSocket: clientSocket)
                #endif
            } else {//명상하러 가기 버튼 누른 후 되돌아올 시 예외처리
                goNext.toggle()
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                    goNext.toggle()
                }
                SharedRepo.sharedVariables.mentalVideoPlayer.queuePlayer.pause()
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
                Text(userResponse)
                    .font(Font.custom("AppleSDGothicNeo-Light", size: 16))
            }
            #elseif PROTOCOL_SERVER
            if responseType.contains("music") {
                MusicButton(imageName: "albumIcon", musicName: "Better Together", artistName: "Pate Jonas")
            } else {
                Text(userResponse)
                    .font(Font.custom("AppleSDGothicNeo-Light", size: 16))
            }
            #endif
        }
        .frame(width: 300, height: 40)
        .foregroundColor(foregroundColor)
        .padding(.all)
        .background(backgroundColor)
        .cornerRadius(17)
        .overlay(
            RoundedRectangle(cornerRadius: 17)
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

#if PROTOCOL_LOCAL
func actionForButton(userResponse: String, clientSocket: Connection) {
    SharedRepo.sharedVariables.response_type.removeAll()
    SharedRepo.sharedVariables.user_response_data.removeAll()
    SharedRepo.sharedVariables.user_response_data.append(userResponse)
    SharedRepo.sharedVariables.user_response_picked = userResponse
    
    SharedRepo.sharedVariables.user_response_count += 1
}

#else
func actionForButton(userResponse: String, responseType: String, clientSocket: Connection) {
    SharedRepo.sharedVariables.user_response.removeAll()
    SharedRepo.sharedVariables.user_response.append(userResponse)
    if responseType.contains("music") {
        SharedRepo.sharedVariables.musicPlayerOn.toggle()
        SharedRepo.sharedVariables.chatbot.removeAll()
        SharedRepo.sharedVariables.response_type.removeAll()
    } else if responseType.contains("diary") {
        SharedRepo.sharedVariables.onelineDiaryOn.toggle()
        SharedRepo.sharedVariables.chatbot.removeAll()
        SharedRepo.sharedVariables.response_type.removeAll()
    } else {
        clientSocket.send(message: userResponse)
    }
    
    SharedRepo.sharedVariables.user_response_count += 1
}
#endif
