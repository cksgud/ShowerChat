//
//  CircleButton.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/09/05.
//

import SwiftUI

struct CircleButton: View {
    let buttonImage: String
    
    var body: some View {
        Button(action: {
            print("동그라미 버튼 눌림")
        }
        ) {
            Image(systemName: buttonImage)
                .padding()
                .background(
                    Circle()
                        .fill(Color.black)
                        .scaledToFill()
                )
                .foregroundColor(Color.orange)
        }
        .padding()
    }
}
