//
//  AudioView.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/10/06.
//

import SwiftUI

struct AudioView: View {
    @State private var navigation: String?
    @State var letterContents: String = ""
    var body: some View {
        if navigation == "mainview" {
            MainView()
        } else {
            VStack {
                HStack {
                    Button(action: {
                        navigation = "mainview"
                        SharedRepo.sharedVariables.usrRespBtnHorizontal = false
                    }) {
                        Image(systemName: "chevron.backward")
                            .font(.system(size: 28, weight: .light))
                    }
                    .padding(.leading, 10)
                    Spacer()
                    Text("어린왕자")
                        .font(Font.custom("AppleSDGothicNeo", size: 20))
                    Spacer()
                    Button(action: {
                        navigation = "mainview"
//                        #if PROTOCOL_SERVER
//                        clientSocket.send(message: letterContents)
//                        #endif
                    }) {
                        Text("OK")
                            .font(Font.custom("AppleSDGothicNeo", size: 22))
                            .foregroundColor(.blue)
                            .padding(.trailing, 20)
                    }
                }
                .foregroundColor(.black)
                .padding(.leading, 10)
                .padding(.top, 5)
                
                Divider()
                Spacer()
                
                Text("어린왕자 오디오 화면은 준비 중이에요")
                    .font(Font.custom("Apple-Chancery", size: 15))
                
                Spacer()
            }
        }
    }
}
