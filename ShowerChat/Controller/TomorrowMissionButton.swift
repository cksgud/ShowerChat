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
        .background(Color.yellow.opacity(0.3))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.blue, lineWidth: 1)
        )
        .multilineTextAlignment(.center)
        .animation(.easeIn)
        .transition(.move(edge: .bottom))
    }
}
