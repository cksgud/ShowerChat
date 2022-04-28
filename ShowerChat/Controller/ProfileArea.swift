//
//  ProfileMaker.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/09/23.
//

import SwiftUI

struct ProfileArea: View {
    let profileData: ProfileData
    
    var body: some View {
        HStack {
            Image(profileData.profileImage)
                .resizable()
                .frame(width:38, height: 38)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .padding(.leading, 24)
            Text(profileData.profileUserName)
                .font(Font.custom("AppleSDGothicNeo", size: 22))
                .padding(.leading, 12)
            Spacer()
            Image(systemName: "xmark")
                .padding(.trailing, 24)
        }
    }
}

