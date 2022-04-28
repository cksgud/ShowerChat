//
//  TouchMeButtonStyle.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/09/10.
//

import SwiftUI

struct TouchMeButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? .black : .white)
            .padding(.all)
            .background(configuration.isPressed ? Color.white : Color.black.opacity(0.2))
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white, lineWidth: 1)
            )
            .multilineTextAlignment(.center)
            .animation(.easeInOut)
            .transition(.move(edge: .bottom))
    }
}
