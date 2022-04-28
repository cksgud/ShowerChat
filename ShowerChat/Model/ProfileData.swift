//
//  ProfileData.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/09/23.
//

import SwiftUI

struct ProfileData {
    let profileImage: String
    let profileUserName: String
}

extension ProfileData {
    static func all() -> [ProfileData] {
        return [
            ProfileData(profileImage: "imgProfile", profileUserName: "Melissa"),
            ProfileData(profileImage: "profileUser", profileUserName: "User")
        ]
    }
}
