//
//  ResponseMaker.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/09/05.
//

import SwiftUI

struct UserResponseData {
    let response: String
}

extension UserResponseData {
    static func all() -> [UserResponseData] {
        return [
            UserResponseData(response: "👍\n고민없어요"),
            UserResponseData(response: "🖐🤚\n잘모르겠어요"),
            UserResponseData(response: "👎\n걱정이 많아요"),
//            UserResponseData(response: "흠.."),
//            UserResponseData(response: "아하\n감사합니다."),
//            UserResponseData(response: "시간을 얼마나\n정하는게..?"),
//            UserResponseData(response: "네 ㅎㅎ"),
//            UserResponseData(response: "또 궁금한게\n있어요!"),
//            UserResponseData(response: "도움이 더\n필요해요"),
//            UserResponseData(response: "👍\n좋아요"),
//            UserResponseData(response: "🖐🤚\n보통이에요"),
//            UserResponseData(response: "👎\n좋지 않아요")
        ]
    }
}
