//
//  ChatBotAnswerText.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/09/29.
//

import SwiftUI

struct ChatBotAnswerText: View {
    @State var opacityOnAppear : Double = 0
    let chatBotAnswer: String
    var body: some View {
        Text(chatBotAnswer)
        .foregroundColor(.white)
        .font(Font.custom(!chatBotAnswer.contains("I") ? "AppleSDGothicNeo-SemiBold" : "Apple-Chancery", size: !chatBotAnswer.contains("I") ? 20 : 16))
        .multilineTextAlignment(.center)
        .opacity(opacityOnAppear)
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                withAnimation(.easeIn(duration: 0.5)) {
                    opacityOnAppear = 1.0
                }
            })
        }
        .animation(.easeIn)
        .transition(.move(edge: .bottom))
        .frame(width: 335)
    }
}
