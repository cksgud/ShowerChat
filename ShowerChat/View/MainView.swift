//
//  MainView.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/09/30.
//

import SwiftUI

struct MainView: View {
    @State private var missionSelected: String?
    @State var isPresented = false
    @State var text = ""
    
    var body: some View {
        if missionSelected == "chatscreen" {
            ChatScreen().environmentObject(Connection())
        } else if missionSelected == "livechat" {
//            LiveChatView(liveChattingText: [String]())
            LiveChatView(liveChattingText: [String](), ip_address: $text)
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
//                        missionSelected = "livechat"
                        isPresented = true
                    }) {
                        Image("icPlus")
                    }
                    .padding(.leading, 24)
                    
                    Spacer()
                    
//                    Button(action: {
//
//                    }) {
//                        Image(systemName: "video.fill")
//                            .foregroundColor(Color.black)
//                    }
                    
                    Button(action: {
                        
                    }) {
                        Image("icMenu")
                    }
                    .padding(.trailing, 24)
                }

                Image(systemName: "link")
                    .foregroundColor(.white)
                    .background(MainProfile())
                    .onTapGesture {
                        missionSelected = "chatscreen"
                    }
                    .padding(.bottom, 28)

                HStack {
                    Text("Daniel").font(Font.custom("HelveticaNeue-Bold", size: 21)).offset(y: -2)
                    Text("님은 ").font(Font.custom("AppleSDGothicNeo-Light", size: 19)).offset(x: -5)
                    Text("강철멘탈").font(Font.custom("AppleSDGothicNeo-Light", size: 19)).foregroundColor(.blue).offset(x: -15)
                    Text("입니다").font(Font.custom("AppleSDGothicNeo-Light", size: 19)).offset(x: -23)
                }
                .offset(x: 15)
                
                #if Melissa
                Text("상담사 Melissa와 매칭되었습니다.").font(Font.custom("AppleSDGothicNeo-UltraLight", size: 13))
                    .padding(.bottom, 35)
                #else
                Text("상담사 Judy와 매칭되었습니다.").font(Font.custom("AppleSDGothicNeo-UltraLight", size: 13))
                    .padding(.bottom, 35)
                #endif
                
                HStack {
                    Spacer()
                    ForEach(0...dayDates.count-1, id:\.self) { num in
                        VStack {
                            if SharedRepo.sharedVariables.dayOfTheWeek[num] == "토" || SharedRepo.sharedVariables.dayOfTheWeek[num] == "일" {
                                Text(SharedRepo.sharedVariables.dayOfTheWeek[num]).font(Font.custom("AppleSDGothicNeo-Regular", size: 12)).foregroundColor(.red)
                            } else {
                                Text(SharedRepo.sharedVariables.dayOfTheWeek[num]).font(Font.custom("AppleSDGothicNeo-Regular", size: 12))
                            }
                            Text(dayDates[num]).font(Font.custom("HelveticaNeue-Medium", size: 19))
                            Spacer().frame(width: 0, height: 11)
                            if SharedRepo.sharedVariables.dayOfTheWeek[num] == SharedRepo.sharedVariables.dayOfToday {
                                Rectangle()
                                    .fill(Color.blue)
                                    .frame(width: 32, height: 3)
                                    .offset(x: -1)
                            }
                        }
                        Spacer()
                    }
                }
                
                ScrollView {
                    Spacer().frame(width: 0, height: 2)

                    VStack {
                        HStack {
                            MainMissionText(missionText: "불안 지수를 낮추기 위한 미션하기!")
                            Spacer()
                        }
                        .padding(.leading, 20)
                        
                        MainMissionButton(missionName: "한줄일기", missionContents: "오늘 하루 어땠나요?!", missionSelected: $missionSelected)
                        MainMissionButton(missionName: "편지쓰기", missionContents: "마음을 띄우는 편지쓰기", missionSelected: $missionSelected)
                        MainMissionButton(missionName: "오디오", missionContents: "\"어린왕자\"로 내 마음 들여다보기", missionSelected: $missionSelected)
                        MainMissionButton(missionName: "명상", missionContents: "생각 비우기 (부정적인 생각 없애기)", missionSelected: $missionSelected)

                        HStack {
                            MainMissionText(missionText: "내일의 Special 한 미션이 있어요~")
                            Spacer()
                        }
                        .padding(.leading, 20)
                        
                        TomorrowMissionButton(missionContents: "👀 내일의 미션 살짝 보러 갈까요~?!")

                        HStack {
                            MainMissionText(missionText: "축하합니다! 뱃지를 획득했어요")
                            Spacer()
                        }
                        .padding(.leading, 20)
                        
                        HStack {
                            Image("goodjobSticker")
                            Image("missionClearStickerDisable")
                            Image("goodjobStickerDisable")
                            Image("perfectStickerDisable")
                        }
                    }
                }
                .background(Color.gray.opacity(0.2))
            }
            .padding(.top, 50)
            .ignoresSafeArea(edges: .all)
            .popup(isPresented: $isPresented) {
                PopupView {
                    LiveChatPopupContentView(isPresented: $isPresented, text: $text, moveToScreen: $missionSelected)
                }
            }
        }
    }
}
