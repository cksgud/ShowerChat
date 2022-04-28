//
//  ChatBotAnswerTextView.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/09/05.
//

import SwiftUI

struct ChatBotAnswerTextView: View {
    let chatBotAnswer: String
    
    var body: some View {
        Text(chatBotAnswer)
        .foregroundColor(.white)
        .font(.title)
        .multilineTextAlignment(.center)
    }
}
