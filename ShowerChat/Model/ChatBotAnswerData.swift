//
//  ChatBotAnswerMaker.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/09/05.
//

import SwiftUI

struct ChatBotAnswerData{
    let answer: String
}

extension ChatBotAnswerData {
    static func all() -> [ChatBotAnswerData] {
        return [
            ChatBotAnswerData(answer: """
                안녕하세요?
                상담사 멜리사입니다.
                당신의 고민은 무엇입니까?!
                """),
            ChatBotAnswerData(answer: """
                아 그렇군요
                그럴땐 걱정하는 시간을 정하고
                걱정하는 것도 좋은 방법입니다.
                """),
            ChatBotAnswerData(answer: """
                도움이 되셨길 바랍니다.
                또 도움 필요하시면
                언제든지 불러주세요.
                """),
            ChatBotAnswerData(answer: """
                오늘은 비가 와서 창가에 앉아
                커피 먹기 좋은 날씨에요.
                오늘은 기분이 어때요??
                """)
        ]
    }
}
