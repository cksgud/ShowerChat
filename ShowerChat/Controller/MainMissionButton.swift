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
    @State private var backgroundColor = Color.blue.opacity(0.1)//Color(red: 106 / 255, green: 100 / 255, blue: 237 / 255)
    @State private var foregroundColor = Color(red: 69 / 255, green: 69 / 255, blue: 71 / 255)//Color.blue.opacity(0.2)
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
        .foregroundColor(foregroundColor)
        .padding(.all)
        .background(backgroundColor)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(red: 76 / 255, green: 74 / 255, blue: 233 / 255), lineWidth: 1)
        )
        .multilineTextAlignment(.center)
        .animation(.easeIn)
        .transition(.move(edge: .bottom))
        .onAppear(perform: {
            if missionName == "한줄일기" && SharedRepo.sharedVariables.onelineDiaryWritten {
                backgroundColor = Color(red: 106 / 255, green: 100 / 255, blue: 237 / 255)
                foregroundColor = Color.white
            } else if missionName == "편지쓰기" && SharedRepo.sharedVariables.letterWritten {
                backgroundColor = Color(red: 106 / 255, green: 100 / 255, blue: 237 / 255)
                foregroundColor = Color.white
            } else if missionName == "명상" && SharedRepo.sharedVariables.meditationDone {
                backgroundColor = Color(red: 106 / 255, green: 100 / 255, blue: 237 / 255)
                foregroundColor = Color.white
            }
        })
    }
}
