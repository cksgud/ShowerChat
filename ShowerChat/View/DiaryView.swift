//
//  DiaryView.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/10/06.
//

import SwiftUI
import DropDown

struct DiaryView: View {
    @EnvironmentObject private var clientSocket: Connection
    @State private var navigation: String?
    @State private var dropDown: DropDown!
    @State private var dropDownSelected = false
    @State private var dropDownTapped = false
    @State private var moodSelected = "기분 선택"
    @State private var faceSelected = "icFaceDim"
    @State var diaryContents: String = ""
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
                    Text("한줄일기")
                        .font(Font.custom("AppleSDGothicNeo-Medium", size: 20))
                    Spacer()
                    Button(action: {
                        navigation = "mainview"
                        if moodSelected != "기분 선택" {
                            diaryContents.append(contentsOf: moodSelected)
                        }
                        #if PROTOCOL_SERVER
                        clientSocket.send(message: diaryContents)
                        #endif
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
                Image(faceSelected)
                HStack {
                    if !dropDownSelected {
                        Text(moodSelected).font(Font.custom("AppleSDGothicNeo-Medium", size: 19)).foregroundColor(.gray.opacity(0.5))
                        dropDownTapped ? Image("icDropdownUp") : Image("icDropDown")
                    } else if dropDownSelected {
                        Text(moodSelected).font(Font.custom("AppleSDGothicNeo-Medium", size: 19)).foregroundColor(.yellow)
                        dropDownTapped ? Image("icDropdownBlackUp") : Image("icDropdownBlack")
                    }
                }
                .onTapGesture {
                    dropDown.show()
                    dropDownTapped.toggle()
                }
                TextField("", text: $diaryContents)
                    .padding()
                    .multilineTextAlignment(.center)
                Spacer()
            }
            .onAppear(perform: {
                #if PROTOCOL_LOCAL
                clientSocket.connect(ip: "192.168.10.102", port: 8000)
                #else
                clientSocket.connect(ip: "34.127.68.142", port: 8008)
                #endif
                dropDownSelected = false
                dropDownTapped = false
                dropDown = DropDown()
                dropDown.dataSource = ["기분 최고 b", "좋아", "별로", "기분 별로 p"]
                dropDown.bottomOffset = CGPoint(x: 0, y: 180)
                dropDown.width = 155
                dropDown.textColor = UIColor.gray
                dropDown.textFont = UIFont.systemFont(ofSize: 18)
                dropDown.selectedTextColor = UIColor.black
                dropDown.cancelAction = {
                    dropDownTapped.toggle()
                }
                dropDown.selectionAction = { [self] (index: Int, item: String) in
                    moodSelected = item
                    dropDownSelected.toggle()
                    dropDownTapped.toggle()
                    if moodSelected.contains("기분 최고 b") {
                        faceSelected = "icFaceSelect"
                    } else {
                        faceSelected = "icFaceDim"
                    }
                }
            })
        }
    }
}
