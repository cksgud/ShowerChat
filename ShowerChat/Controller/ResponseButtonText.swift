//
//  ResponseButtonText.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/10/13.
//

import SwiftUI

struct ResponseButtonText: View {
    let userResponse: String
    var body: some View {
        if userResponse.contains("좋아요") {
            VStack {
                Image("emojiGood")
                Text(userResponse)
                    .font(Font.custom("AppleSDGothicNeo-Light", size: 16))
            }
        } else if userResponse.contains("보통이에요") {
            VStack {
                Image("emojiNormal")
                Text(userResponse)
                    .font(Font.custom("AppleSDGothicNeo-Light", size: 16))
            }
        } else if userResponse.contains("우울해요") {
            VStack {
                Image("emojiBad")
                Text(userResponse)
                    .font(Font.custom("AppleSDGothicNeo-Light", size: 16))
            }
        } else {//Default 값
            Text(userResponse)
                .font(Font.custom("AppleSDGothicNeo-Light", size: 16))
        }
    }
}
