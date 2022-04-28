//
//  ResponseButton.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/09/05.
//

import SwiftUI

struct UserResponseButton: View {
    let response: String
    
    var body: some View {
        Button(action: {
            PlayRepo.playShared.isPlayOn = !PlayRepo.playShared.isPlayOn
        }) {
            Text(response).font(.body)
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
