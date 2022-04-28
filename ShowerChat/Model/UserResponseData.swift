//
//  ResponseMaker.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/09/05.
//

import SwiftUI

struct UserResponseData: Hashable {
    let responses: [String]
}

extension UserResponseData {
    static func all() -> [UserResponseData] {
        return [
//            UserResponseData(responses: ["👍🏻\n\n좋아요", "🖐🏻🤚🏻\n\n보통이에요", "👎🏻\n\n우울해요"]),
            UserResponseData(responses: ["좋아요", "보통이에요", "우울해요"]),
            UserResponseData(responses: ["맞아요", "괜찮아요"]),
            UserResponseData(responses: ["▶ Better Together  Pate Jonas", "다음에 들을게요"]),
            UserResponseData(responses: ["조금은 나아진 것 같아요", "그저 그래요"]),
            UserResponseData(responses: ["조금은 나아진 것 같아요", "그저 그래요"]),
            UserResponseData(responses: ["그게 무슨 의미에요?"]),
            UserResponseData(responses: ["그렇군요"]),
            UserResponseData(responses: ["친한 친구와 수다떨기", "가족과 시간 보내기"]),
            UserResponseData(responses: ["한줄 일기 쓰러 가기", "대화 이어가기"]),
            UserResponseData(responses: ["공감해요"]),
            UserResponseData(responses: ["공감해요"]),
            UserResponseData(responses: ["다음"]),
            UserResponseData(responses: ["꼭 기억할게요"]),
            UserResponseData(responses: ["많이 좋아졌어요. 고마워요.", "대화 종료하기"]),
            UserResponseData(responses: ["명상하러 가기", "대화 종료하기"]),
            UserResponseData(responses: ["명상 끝내기"]),
            UserResponseData(responses: [""])
        ]
    }
}
