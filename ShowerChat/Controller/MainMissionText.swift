//
//  MainMissionText.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/10/06.
//

import SwiftUI

struct MainMissionText: View {
    let missionText: String
    var body: some View {
        Text(missionText)
            .font(Font.custom("AppleSDGothicNeo-Medium", size: 17))
            .padding(.top, 20)
    }
}
