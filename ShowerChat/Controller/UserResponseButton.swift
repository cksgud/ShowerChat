//
//  ResponseButton.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/09/05.
//

import SwiftUI

struct UserResponseButton: View {
    let userResponseData: UserResponseData
    
    var body: some View {
        Button(action: {
            SharedRepo.sharedVariables.usrRspBtnVisible.toggle()
            SharedRepo.sharedVariables.ansNum += 1
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                SharedRepo.sharedVariables.usrRspBtnVisible.toggle()
            }
        }) {
            Text(userResponseData.response).font(.body)
        }
        .foregroundColor(.white)
        .padding(.all)
        .background(Color.purple)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white, lineWidth: 2)
        )
    }
}
