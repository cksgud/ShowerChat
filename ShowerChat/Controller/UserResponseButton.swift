//
//  ResponseButton.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/09/05.
//

import SwiftUI

struct UserResponseButton: View {
    @EnvironmentObject private var clientSocket: Connection
    let userResponse: String
    
    var body: some View {
        Button(action: {
            clientSocket.send(message: userResponse)// 소켓 통신, 버튼 문구 서버 전송
            SharedRepo.sharedVariables.usrRspBtnVisible.toggle()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                SharedRepo.sharedVariables.usrRspBtnVisible.toggle()
            }
        }) {
            Text(userResponse).font(.body)
        }
        .buttonStyle(TouchMeButtonStyle())
    }
}
