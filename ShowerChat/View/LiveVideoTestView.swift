//
//  LiveVideoTestView.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/10/27.
//

import SwiftUI

struct LiveVideoTestView: View {
    var body: some View {
        ZStack {
            LiveVideo()
                .scaleEffect(x: 1.7, y: 1.7, anchor: .center)
                .edgesIgnoringSafeArea(.all)
        }
    }
}
