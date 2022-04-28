//
//  ChatBotAnswerMaker.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/09/05.
//

import SwiftUI

struct ChatBotAnswerMaker{
    let answer: String
}

extension ChatBotAnswerMaker {
    static func all() -> [ChatBotAnswerMaker] {
        return [
            ChatBotAnswerMaker(answer: """
                안녕하세요?
                상담사 멜리사입니다.
                당신의 고민은 무엇입니까?!
                """),
            ChatBotAnswerMaker(answer: """
                아 그렇군요
                그럴땐 걱정하는 시간을 정하고 걱정하는 것도 좋은 방법입니다.
                """)
        ]
    }
}
