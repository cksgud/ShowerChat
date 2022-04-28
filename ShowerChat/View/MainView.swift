//
//  MainView.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/09/30.
//

import SwiftUI
import DropDown

struct MainView: View {
    @State private var missionSelected: String?
    
//    let topPadding = CGFloat(50)//UIApplication.shared.keyWindow!.safeAreaInsets.top
//    let bottomPadding = CGFloat(35)//UIApplication.shared.keyWindow!.safeAreaInsets.bottom
    
    var body: some View {
        if missionSelected == "chatscreen" {
            ChatScreen().environmentObject(Connection())
        } else if missionSelected == "diary" {
            DiaryView().environmentObject(Connection())
        } else if missionSelected == "letter" {
            LetterView().environmentObject(Connection())
        } else if missionSelected == "audio" {
            AudioView()
        } else if missionSelected == "meditation" {
            MeditationView()
        } else {
            VStack {
                HStack {
                    Button(action: {
                        
                    }) {
                        Image("icPlus")
                    }
                    .padding(.leading, 15)
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }) {
                        Image("icMenu")
                    }
                    .padding(.trailing, 15)
                }
//                .padding(.top, 2)
                .padding(.bottom, 30)

                Image(systemName: "link")
                    .foregroundColor(.white)
                    .background(MainProfile())
                    .offset(y: -30)
                    .onTapGesture {
                        missionSelected = "chatscreen"
                    }

                ScrollView {
                    Image("mainComponents")
                        .resizable()
                        .frame(height: 400)

                    VStack {
                        MainMissionText(missionText: "불안 지수를 낮추기 위한 미션하기!")
                        MainMissionButton(missionName: "한줄일기", missionContents: "오늘 하루 어땠나요?!", missionSelected: $missionSelected)
                        MainMissionButton(missionName: "편지쓰기", missionContents: "마음을 띄우는 편지쓰기", missionSelected: $missionSelected)
                        MainMissionButton(missionName: "오디오", missionContents: "\"어린왕자\"로 내 마음 들여다보기", missionSelected: $missionSelected)
                        MainMissionButton(missionName: "명상", missionContents: "생각 비우기 (부정적인 생각 없애기)", missionSelected: $missionSelected)

                        MainMissionText(missionText: "내일의 Special 한 미션이 있어요~")
                        TomorrowMissionButton(missionContents: "👀 내일의 미션 살짝 보러 갈까요~?!")

                        MainMissionText(missionText: "축하합니다! 뱃지를 획득했어요")
                        HStack {
                            Image("goodjobSticker")
                            Image("missionClearStickerDisable")
                            Image("goodjobStickerDisable")
                            Image("perfectStickerDisable")
                        }
                    }
                }
                .background(Color.gray.opacity(0.2))
                .ignoresSafeArea(edges: .all)
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}
