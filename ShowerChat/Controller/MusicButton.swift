//
//  MusicButtonFormat.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/09/29.
//

import SwiftUI

struct MusicButton: View {
    var imageName: String
    var musicName: String
    var artistName: String
    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .frame(width: 73, height: 73)
                .cornerRadius(17)
                .offset(x: -10)
                .scaleEffect(x: 1.15, y: 1.15, anchor: .center)
            VStack {
                Text(musicName)
                    .font(.system(size: 18, weight: .bold))
                Text(artistName)
                    .font(.system(size: 14))
                    .offset(x: -32)
            }
            Spacer()
            Image(systemName: "play.fill")
                .frame(width: 14, height: 14)
        }
    }
}
