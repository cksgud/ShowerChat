//
//  TestButton.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/09/13.
//

import SwiftUI

struct TestButton: View {
    @EnvironmentObject private var clientSocket: Connection
    let response: String
    
    var body: some View {
        Button(action: {
            clientSocket.send(message: response)
            SharedRepo.sharedVariables.ansNum += 1
            SharedRepo.sharedVariables.btnNum1 += 3
            SharedRepo.sharedVariables.btnNum2 += 3
            SharedRepo.sharedVariables.btnNum3 += 3
            SharedRepo.sharedVariables.usrRspBtnVisible.toggle()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                SharedRepo.sharedVariables.usrRspBtnVisible.toggle()
            }
        }) {
            Text(response).font(.body)
        }
        .buttonStyle(TouchMeButtonStyle())
    }
}
