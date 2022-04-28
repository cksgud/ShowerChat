//
//  ReportView.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/09/30.
//

import SwiftUI

struct ReportView: View {
    @State private var foregroundColor = Color.white
    @State private var backgroundColor = Color.black.opacity(0.3)
    @State private var selectionMentalCare: String?
    var body: some View {
        if selectionMentalCare == "meditation" {
            MeditationView()
        } else if selectionMentalCare == "reportDetail" {
            ReportDetailView()
        } else {
            VStack {
                HStack {
                    Button(action: {
                        selectionMentalCare = "meditation"
                        SharedRepo.sharedVariables.usrRespBtnHorizontal = false
                    }) {
                        Image(systemName: "chevron.backward")
                            .font(.system(size: 28, weight: .light))
                    }
                    .padding(.leading, 10)
                    Spacer()
                    Text("Daniel의 감정 리포트")
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
                Image("imgReport")
                Text("""
                    불안 지수가 기존보다 20% 감소했어요.
                    최근 자주 우울한 감정을 느끼는 것 같아서
                    감정을 잘 들여다 보아야 할 거 같아요.

                    너무 슬픔에 잠기지 않도록
                    주변에 친한 사람들에게 속마음을
                    털어 놓는 것도 큰 도움이 될거에요.
                    """)
                    .multilineTextAlignment(.center)
                    .lineSpacing(12)
                    .font(Font.custom("AppleSDGothicNeo", size: 18))
                Spacer()
                Button(action: {
                    backgroundColor = .white
                    foregroundColor = .black
                    selectionMentalCare = "reportDetail"
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        withAnimation(.easeIn(duration: 1.0)) {
                            backgroundColor = Color.black.opacity(0.3)
                            foregroundColor = .white
                        }
                    })
                }) {
                    Text("감정 리포트 자세히 보기")
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
                Image("imgMeditation2")
            )
        }
    }
}
