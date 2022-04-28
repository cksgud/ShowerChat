//
//  TomorrowMissionButton.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/10/06.
//

import SwiftUI

struct TomorrowMissionButton: View {
    let missionContents: String
    var body: some View {
        Button(action:{
            
        }) {
            HStack {
                VStack {
                    HStack {
                        Text(missionContents)
                            .font(Font.custom("AppleSDGothicNeo-Light", size: 17))
                            .foregroundColor(Color(red: 18 / 255, green: 18 / 255, blue: 18 / 255))
                        Spacer()
                    }
                }
                Spacer()
                Image(systemName: "checkmark")
            }
        }
        .frame(width: 300, height: 40)
        .foregroundColor(.gray)
        .padding(.all)
        .background(Color(red: 255 / 255, green: 215 / 255, blue: 174 / 255))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(red: 255 / 255, green: 215 / 255, blue: 174 / 255), lineWidth: 1)
        )
        .multilineTextAlignment(.center)
        .animation(.easeIn)
        .transition(.move(edge: .bottom))
    }
}
