//
//  MainMissionButton.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/10/06.
//

import SwiftUI

struct MainMissionButton: View {
    let missionName: String
    let missionContents: String
    @Binding var missionSelected: String?
    
    var body: some View {
        Button(action:{
            if missionName.contains("일기") {
                missionSelected = "diary"
            } else if missionName.contains("편지") {
                missionSelected = "letter"
            } else if missionName.contains("오디오") {
                missionSelected = "audio"
            } else if missionName.contains("명상") {
                missionSelected = "meditation"
            }
        }) {
            HStack {
                VStack {
                    HStack {
                        Text(missionName)
                            .font(Font.custom("AppleSDGothicNeo-Regular", size: 11))
                        Spacer()
                    }
                    HStack {
                        if missionName.contains("오디오") {
                            Image("icAudioWaves")
                        }
                        Text(missionContents)
                            .font(Font.custom("AppleSDGothicNeo-Light", size: 16))
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
        .background(Color.blue.opacity(0.2))
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
