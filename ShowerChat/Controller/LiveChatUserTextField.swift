//
//  LiveChatUserTextField.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/10/19.
//

import SwiftUI

struct LiveChatUserTextField: View {
    @State private var liveQuestionString: String = ""
    @Binding var liveChattingText: [String]
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text("채팅상담 (실시간 영상 교체 예정)")
                        .foregroundColor(.black).opacity(0.5)
                        .font(Font.custom("AppleSDGothicNeo-Medium", size: 12))
                        .padding(.top, 10)
                        .padding(.leading, 10)
                    Spacer()
                }
                HStack {
                    TextField("", text: $liveQuestionString)
                        .disableAutocorrection(true)
                        .padding(.leading, 10)
                        .accentColor(.black)
                        .foregroundColor(.black)
                    Spacer()
                    
                    Image(systemName: "arrow.right.circle")
                        .resizable()
                        .frame(width: 27, height: 27)
                        .padding(.trailing, 20)
                        .foregroundColor(.black)
                        .onTapGesture {
                            if liveQuestionString.contains("http") {
                                SharedRepo.sharedVariables.liveURL = liveQuestionString
                            }
                            if !liveQuestionString.isEmpty {
                                liveChattingText.append(liveQuestionString)
                                liveQuestionString = ""
                            }
                        }
                }
                .offset(y: -5)
            }
        }
        .background(Color.white)
        .frame(height: 65)
        .edgesIgnoringSafeArea(.all)
        
    }
}
