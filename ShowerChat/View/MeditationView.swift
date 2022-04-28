//
//  MeditationView.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/09/29.
//

import SwiftUI

struct MeditationView: View {
    @State private var foregroundColor = Color.white
    @State private var backgroundColor = Color.black.opacity(0.3)
    @State private var selectionMentalCare: String?
    var body: some View {
        if selectionMentalCare == "chatscreen" {
            ChatScreen()
        } else if selectionMentalCare == "report" {
            ReportView()
        } else {
            VStack {
                HStack {
                    Button(action: {
                        selectionMentalCare = "chatscreen"
                        SharedRepo.sharedVariables.usrRespBtnHorizontal = false
                    }) {
                        Image(systemName: "chevron.backward")
                            .font(.system(size: 28, weight: .light))
                    }
                    .padding(.leading, 10)
                    Text("5분 명상하기")
                        .font(Font.custom("AppleSDGothicNeo", size: 22))
                        .padding(.leading, 10)
                    Spacer()
                    Image(systemName: "xmark")
                        .padding(.trailing, 27)
                }
                .foregroundColor(.white)
                .padding(.leading, 10)
                .padding(.top, 5)
                Spacer()
                Text("⏱ 05:00")
                    .foregroundColor(.white)
                    .font(Font.custom("GujaratiMT", size: 40))
                Text("""
                    5분간 명상을 하면
                    하루 기분에 도움이 많이 돼요

                    지금부터 명상을 시작해볼게요
                    방에 조도를 낮추고
                    편안한 자세로 앉아 주세요.

                    숨을 깊게 들이 마시고
                    잠시 멈추었다
                    다시 숨을 내쉬어 보세요
                    """)
                    .multilineTextAlignment(.center)
                    .lineSpacing(12)
                    .font(Font.custom("AppleSDGothicNeo", size: 18))
                    .frame(width: 217, height: 320)
                Spacer()
                Button(action: {
                    backgroundColor = .white
                    foregroundColor = .black
                    selectionMentalCare = "report"
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        withAnimation(.easeIn(duration: 1.0)) {
                            backgroundColor = Color.black.opacity(0.3)
                            foregroundColor = .white
                        }
                    })
                }) {
                    Text("명상 끝내기")
                        .font(Font.custom("AppleSDGothicNeo", size: 16))
                }
                .frame(width: 300, height: 40)
                .foregroundColor(foregroundColor)
                .padding(.all)
                .background(backgroundColor)
                .cornerRadius(17)
                .overlay(
                    RoundedRectangle(cornerRadius: 17)
                        .stroke(Color.white, lineWidth: 1)
                )
                .multilineTextAlignment(.center)
            }
            .background(
                Image("imgMeditation")
            )
        }
    }
}
