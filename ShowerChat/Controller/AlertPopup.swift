//
//  AlertPopup.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/09/29.
//

import SwiftUI

struct AlertPopup: View {
    @State var opacityOnAppear : Double = 0
    let alertMessage: String
    
    var body: some View {
        VStack {
            Spacer()
            Button(action: {
            }) {
                Text(alertMessage).font(.body)
            }
            .frame(width: 300, height: 40)
            .foregroundColor(Color.white)
            .padding(.all)
            .background(Color.black.opacity(0.7))
            .cornerRadius(17)
            .overlay(
                RoundedRectangle(cornerRadius: 17)
                    .stroke(Color.white, lineWidth: 1)
            )
            .multilineTextAlignment(.center)
            .opacity(opacityOnAppear)
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    withAnimation(.easeIn(duration: 1.0)) {
                        opacityOnAppear = 1.0
                    }
                })
            }
            .animation(.easeIn)
            .transition(.move(edge: .bottom))
        }
    }
}
