//
//  ChatBotAnswerMaker.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/09/05.
//

import SwiftUI

struct ChatBotAnswerData{
    let answer: [String]
}

#if Melissa
extension ChatBotAnswerData {
    static func all() -> [ChatBotAnswerData] {
        return [
            ChatBotAnswerData(answer: ["""
                안녕하세요. Melissa 에요.
                오늘은 기분이 어때요?
                """]),
            ChatBotAnswerData(answer: ["""
                기분이 안 좋았군요.
                오늘의 당신에게는 위로가 필요하겠네요
                """]),
            ChatBotAnswerData(answer: ["""
                기분을 한결 좋게 해줄 음악이 있는데
                한번 들어볼래요?
                """]),
            ChatBotAnswerData(answer: ["""
                💿 나른하고 피곤한 하루 날려버릴 노래
                """]),
            ChatBotAnswerData(answer: ["""
                음악을 듣고 나니 어때요?
                """]),
            ChatBotAnswerData(answer: ["""
                당신에게 들려주고 싶은 이야기가 있어요
                감정 날씨🌤라고 들어본 적 있나요?
                """]),
            ChatBotAnswerData(answer: ["""
                우리의 감정도 날씨와 비슷해요.
                맑은 해가 뜨기도 하고, 때로는 폭풍🌧이 치기도 하죠.
                """]),
            ChatBotAnswerData(answer: ["""
                오늘처럼 우울할 때,
                당신을 버틸 수 있도록 해주는게 뭘까요?
                """]),
            ChatBotAnswerData(answer: ["""
                친한 친구와 보냈던 즐거운 기분을
                📝 한줄 일기로 남겨볼래요?
                """]),
            ChatBotAnswerData(answer: ["""
                """]),
            ChatBotAnswerData(answer: ["""
                좋아요. 내가 가진 소중한 것들에 대해서
                잊지 않는게 중요해요.
                """]),
            ChatBotAnswerData(answer: ["""
                어린왕자📒 책 중에 이런 문장이 있어요
                "나는 나 자신이고, 나 자신이 될 필요가 있다"
                I am Who I am and
                I have the need to be
                """]),
            ChatBotAnswerData(answer: ["""
                우울한 기분이 들 때면, 이 말을 한번 떠올려보세요.
                """]),
            ChatBotAnswerData(answer: ["""
                오늘의 우울했던 기분은 괜찮아졌나요?
                """]),
            ChatBotAnswerData(answer: ["""
                다행이에요. 이제 잠시 조용히
                생각해보는 시간을 가져볼까요.
                """]),
            ChatBotAnswerData(answer: ["""
                """])
        ]
    }
}
#else
extension ChatBotAnswerData {
    static func all() -> [ChatBotAnswerData] {
        return [
            ChatBotAnswerData(answer: ["""
                안녕? 난 Judy 야
                오늘은 기분이 좀 어때?
                """]),
            ChatBotAnswerData(answer: ["""
                기분이 우울했구나
                오늘은 마음이 많이 힘들었겠네
                """]),
            ChatBotAnswerData(answer: ["""
                기분 좋게 해줄 음악이 있는데
                한번 들어볼래?
                """]),
            ChatBotAnswerData(answer: ["""
                💿 나른하고 피곤한 하루 날려버릴 노래
                """]),
            ChatBotAnswerData(answer: ["""
                음악을 듣고 나니 어때?
                """]),
            ChatBotAnswerData(answer: ["""
                혹시 감정 날씨🌤라고 들어본 적 있어?
                """]),
            ChatBotAnswerData(answer: ["""
                우리 감정도 날씨와 비슷한 것 같아.
                맑은 해가 뜨기도 하고, 때로는 폭풍🌧이 치기도 하잖아.
                """]),
            ChatBotAnswerData(answer: ["""
                오늘처럼 우울할 때,
                너를 도와줄 수 있는게 있을까?
                """]),
            ChatBotAnswerData(answer: ["""
                친한 친구와 좋았던 기억을
                📝 한줄 일기로 남겨봐.
                """]),
            ChatBotAnswerData(answer: ["""
                """]),
            ChatBotAnswerData(answer: ["""
                그래~ 네가 가진 소중한 것들을 잊지 마
                """]),
            ChatBotAnswerData(answer: ["""
                어린왕자📒 책 중에
                내가 가장 좋아하는 문장이 있는데
                "나는 나 자신이고, 나 자신이 될 필요가 있다"
                I am Who I am and I have the need to be
                """]),
            ChatBotAnswerData(answer: ["""
                우울한 기분이 들면,
                이 말을 한번 떠올려봐.
                """]),
            ChatBotAnswerData(answer: ["""
                기분 이제 괜찮아?
                """]),
            ChatBotAnswerData(answer: ["""
                다행이야~ 그럼 우리 같이
                하루를 정리해볼까?
                """]),
            ChatBotAnswerData(answer: ["""
                """])
        ]
    }
}
#endif
