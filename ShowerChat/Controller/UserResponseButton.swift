//
//  ResponseButton.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/09/05.
//

import SwiftUI

struct UserResponseButton: View {
    @EnvironmentObject private var clientSocket: Connection
    let userResponseData: UserResponseData
    
    var body: some View {
        Button(action: {
            clientSocket.send(message: userResponseData.response)// 소켓 통신, 버튼 문구 서버 전송
            SharedRepo.sharedVariables.usrRspBtnVisible.toggle()
            SharedRepo.sharedVariables.ansNum += 1
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                SharedRepo.sharedVariables.usrRspBtnVisible.toggle()
            }
        }) {
            Text(SharedRepo.sharedVariables.responses.count > 0 ? SharedRepo.sharedVariables.responses[1] : userResponseData.response).font(.body)
        }
        .buttonStyle(TouchMeButtonStyle())
    }
}
