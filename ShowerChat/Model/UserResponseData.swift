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
            UserResponseData(response: "즐거워요"),
            UserResponseData(response: "행복해요"),
            UserResponseData(response: "걱정이 많아요")
        ]
    }
}
