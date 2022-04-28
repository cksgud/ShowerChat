//
//  ChatBotAnswerTextView.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/09/05.
//

import SwiftUI

struct ChatBotAnswerTextView: View {
    @State var opacityOnAppear : Double = 0
    let chatBotAnswer: [String]
    var body: some View {
        VStack {
            ForEach(chatBotAnswer, id:\.self ) { chatbotAnswerText in
                ChatBotAnswerText(chatBotAnswer: chatbotAnswerText)
            }
        }
        .lineSpacing(11)
    }
}
