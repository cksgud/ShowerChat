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
    
    var body: some View {
        Button(action: {
            backgroundColor = .white
            foregroundColor = .black
            SharedRepo.sharedVariables.onAppearNumber = 1.0
            
            if userResponse == "명상하러 가기" {
                self.selectionMentalCare = "meditation"
            } else {//명상하러 가기 버튼 누른 후 되돌아올 시 예외처리
                #if PROTOCOL_LOCAL
                SharedRepo.sharedVariables.response_type.removeAll()
                SharedRepo.sharedVariables.user_response_data.removeAll()
                SharedRepo.sharedVariables.user_response_data.append(userResponse)
                SharedRepo.sharedVariables.user_response_picked = userResponse
                #elseif PROTOCOL_SERVER
                SharedRepo.sharedVariables.user_response.removeAll()
                SharedRepo.sharedVariables.user_response.append(userResponse)
                if responseType.contains("music") {
                    SharedRepo.sharedVariables.musicPlayerOn.toggle()
                    SharedRepo.sharedVariables.response_type.removeAll()
                } else {
                    clientSocket.send(message: userResponse)
                }
                #endif
                
                SharedRepo.sharedVariables.user_response_count += 1
            }
        }) {
            #if PROTOCOL_LOCAL
            if userResponse.contains("▶") {
                MusicButton(imageName: "albumIcon", musicName: "Better Together", artistName: "Pate Jonas")
            } else {
                Text(userResponse)
                    .font(Font.custom("AppleSDGothicNeo", size: 16))
            }
            #elseif PROTOCOL_SERVER
            if responseType.contains("music") {
                MusicButton(imageName: "albumIcon", musicName: "Better Together", artistName: "Pate Jonas")
            } else {
                Text(userResponse)
                    .font(Font.custom("AppleSDGothicNeo", size: 16))
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
