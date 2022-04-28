//
//  AfterChatView.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/10/18.
//

import SwiftUI
import AVKit

struct AfterChatView: View {
    @State private var foregroundColor = Color.white
    @State private var backgroundColor = Color(red: 106 / 255, green: 100 / 255, blue: 237 / 255)
    @State private var selectionMentalCare: String?
    
    var body: some View {
        if selectionMentalCare == "meditation" {
            MeditationView()
        } else if selectionMentalCare == "mainview" {
            MainView()
        } else {
            ZStack {
                VStack {
                    HStack {
                        Button(action: {
                            selectionMentalCare = "meditation"
                            SharedRepo.sharedVariables.usrRespBtnHorizontal = false
                        }) {
                            Image(systemName: "chevron.backward")
                                .font(.system(size: 28, weight: .light))
                        }
                        .padding(.leading, 20)
                        Spacer()
                        Button(action: {
                            selectionMentalCare = "mainview"
                        }) {
                            Image("icClose")
                        }
                        .padding(.trailing, 27)
                    }
                    .foregroundColor(.white)
                    .padding(.top, 60)
                    
                    Image("icChatGood")
                        .frame(width: 150, height: 150)
                        .padding(.top, 88)
                    Text("""
                        참 잘했어요! 👍🏻
                        Daniel과의 대화 즐거웠어요.
                        기분이 울적하거나, 고민이 있다면
                        언제든지 Melissa를 찾아주세요.
                        """)
                        .multilineTextAlignment(.leading)
                        .lineSpacing(12)
                        .font(Font.custom("AppleSDGothicNeo-Regular", size: 15))
                        .foregroundColor(.white)
                        .background(
                            Image("txtBg")
                                .frame(width: 257, height: 159)
                                .offset(y: -7)
                        )
                        .padding(.top, 27)
                    Spacer()
                    Button(action: {
                        backgroundColor = .white
                        foregroundColor = .black
                        selectionMentalCare = "mainview"
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                            withAnimation(.easeIn(duration: 1.0)) {
                                backgroundColor = Color.black.opacity(0.3)
                                foregroundColor = .white
                            }
                        })
                    }) {
                        Text("대화 종료하기")
                            .font(Font.custom("AppleSDGothicNeo-Light", size: 16))
                    }
                    .frame(width: 300, height: 40)
                    .foregroundColor(foregroundColor)
                    .padding(.all)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(17)
                    .overlay(
                        RoundedRectangle(cornerRadius: 17)
                            .stroke(Color(red: 192 / 255, green: 196 / 255, blue: 228 / 255), lineWidth: 1)
                    )
                    .multilineTextAlignment(.center)
                    .offset(y: -36)
                }
            }
            .background(backgroundColor)
            .edgesIgnoringSafeArea(.all)
        }
    }
}
