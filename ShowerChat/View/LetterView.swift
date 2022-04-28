//
//  LetterView.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/10/06.
//

import SwiftUI

struct LetterView: View {
    @EnvironmentObject private var clientSocket: Connection
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
                    Text("편지쓰기")
                        .font(Font.custom("AppleSDGothicNeo-Medium", size: 20))
                    Spacer()
                    Button(action: {
                        navigation = "mainview"
                        #if PROTOCOL_SERVER
                        clientSocket.send(message: letterContents)
                        #endif
                    }) {
                        Image(systemName: "paperplane")
                            .font(.system(size: 28, weight: .light))
                            .padding(.trailing, 20)
                    }
                }
                .foregroundColor(.black)
                .padding(.leading, 10)
                .padding(.top, 5)
                
                VStack {
                    HStack {
                        Text("From")
                            .font(Font.custom("SignPainter", size: 30))
                        Image("profileUser")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .padding(.leading, 10)
                        Text("Daniel")
                            .font(Font.custom("HelveticaNeue", size: 20))
                            .padding(.leading, 10)
                    }
                    .padding()
                    .foregroundColor(.white)
                    
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 300, height: 1)
                        .offset(y: -10)
                    
                    TextField("", text: $letterContents)
                        .padding()
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .accentColor(.white)
                    Spacer()
                }
                .background(Color.green.opacity(0.5))
                .ignoresSafeArea(edges: .all)
            }
            .onAppear(perform: {
                #if PROTOCOL_LOCAL
                clientSocket.connect(ip: "192.168.10.102", port: 8000)
                #else
                clientSocket.connect(ip: "34.127.68.142", port: 8008)
                #endif
            })
        }
    }
}

struct LabelledDivider: View {

    let label: String
    let horizontalPadding: CGFloat
    let color: Color

    init(label: String, horizontalPadding: CGFloat = 20, color: Color = .white) {
        self.label = label
        self.horizontalPadding = horizontalPadding
        self.color = color
    }

    var body: some View {
        HStack {
            line
            Text(label).foregroundColor(color)
            line
        }
    }

    var line: some View {
        VStack { Divider().background(color) }.padding(horizontalPadding)
    }
}
