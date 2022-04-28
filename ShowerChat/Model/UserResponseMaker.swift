//
//  ResponseMaker.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/09/05.
//

import SwiftUI

struct UserResponseMaker{
    let response: String
}

extension UserResponseMaker {
    static func all() -> [UserResponseMaker] {
        return [
            UserResponseMaker(response: "즐거워요"),
            UserResponseMaker(response: "행복해요"),
            UserResponseMaker(response: "걱정이 많아요")
        ]
    }
}
