//
//  ChatBotAnswerTextView.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/09/05.
//

import SwiftUI

struct ChatBotAnswerTextView: View {
    let chatBotAnswerData: ChatBotAnswerData
    
    var body: some View {
        Text(SharedRepo.sharedVariables.responses.count > 0 ? SharedRepo.sharedVariables.responses[0] : chatBotAnswerData.answer)
        .foregroundColor(.white)
        .font(.title)
        .multilineTextAlignment(.center)
    }
}
