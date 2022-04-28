//
//  MainProfile.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/10/06.
//

import SwiftUI

struct MainProfile: View {
    var body: some View {
        HStack {
            ZStack {
                Image("imgProfile")
                    .resizable()
                    .frame(width:60, height: 60)
                Image("profileUser")
                    .resizable()
                    .frame(width:60, height: 60)
                    .offset(x:-50)
            }
            .offset(x: 25)
        }
    }
}

struct MainProfile_Previews: PreviewProvider {
    static var previews: some View {
        MainProfile()
    }
}
