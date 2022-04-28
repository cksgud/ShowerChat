//
//  Diary.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/09/28.
//

import SwiftUI

struct Diary: View {
    @EnvironmentObject private var clientSocket: Connection
    @State private var diaryContents: String = ""
    @State var alertPresent = 0
    @Binding var goNext: Bool
    var body: some View {
        if alertPresent == 0 {
            HStack {
                VStack {
                    HStack {
                        Text("한줄일기")
                            .foregroundColor(.black).opacity(0.5)
                            .font(Font.custom("AppleSDGothicNeo-Medium", size: 12))
                            .padding(.top, 10)
                            .padding(.leading, 10)
    //                        .frame(width: 84, height: 15)
                        Spacer()
                    }
                    HStack {
                        TextField("", text: $diaryContents)
                            .disableAutocorrection(true)
                            .padding(.leading, 10)
                            .accentColor(.black)
                            .foregroundColor(.black)
                        Spacer()
                        Text("취소").foregroundColor(.red)
                            .font(Font.custom("AppleSDGothicNeo-Medium", size: 16))
                            .padding(.trailing, 10)
                            .onTapGesture {
                                goNext.toggle()
                                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                                    goNext.toggle()
                                }
                                clientSocket.send(message: "일기작성취소")
                                alertPresent = 1
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                                    withAnimation(.easeIn(duration: 1.0)) {
                                        SharedRepo.sharedVariables.response_type.removeAll()
                                        #if PROTOCOL_LOCAL
                                        SharedRepo.sharedVariables.user_response_data.removeAll()
                                        #else
                                        SharedRepo.sharedVariables.user_response.removeAll()
                                        #endif
                                        SharedRepo.sharedVariables.user_response_picked.removeAll()
                                        SharedRepo.sharedVariables.user_response_count += 1
                                    }
                                })
                            }
                        
                        Image(systemName: "arrow.right.circle")
                            .resizable()
                            .frame(width: 27, height: 27)
                            .padding(.trailing, 20)
                            .foregroundColor(.black)
                            .onTapGesture {
                                goNext.toggle()
                                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                                    goNext.toggle()
                                }
                                if !diaryContents.isEmpty {
//                                    clientSocket.send(message: diaryContents)
                                    SharedRepo.sharedVariables.diaryData.append(diaryContents)
                                }
                                alertPresent = 2
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                                    withAnimation(.easeIn(duration: 1.0)) {
                                        SharedRepo.sharedVariables.response_type.removeAll()
                                        #if PROTOCOL_LOCAL
                                        SharedRepo.sharedVariables.user_response_data.removeAll()
                                        #else
                                        SharedRepo.sharedVariables.onelineDiaryOn.toggle()
                                        clientSocket.send(message: "일기작성완료")
                                        SharedRepo.sharedVariables.user_response.removeAll()
                                        #endif
                                        SharedRepo.sharedVariables.user_response_picked.removeAll()
                                        SharedRepo.sharedVariables.user_response_count += 1
                                    }
                                })
                            }
                    }
                    Spacer()
                }
            }
            .background(Color.white)
            .frame(height: 65)
            .edgesIgnoringSafeArea(.all)
        } else if alertPresent == 1 {
            AlertPopup(alertMessage: "한줄 일기 작성 취소 했습니다")
        } else if alertPresent == 2 {
            AlertPopup(alertMessage: "한줄 일기 작성 완료 했습니다")
        }
        
    }
}

struct CustomTextField: UIViewRepresentable {

    class Coordinator: NSObject, UITextFieldDelegate {

        @Binding var text: String
        var didBecomeFirstResponder = false

        init(text: Binding<String>) {
            _text = text
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }

    }

    @Binding var text: String
    var isFirstResponder: Bool = false

    func makeUIView(context: UIViewRepresentableContext<CustomTextField>) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        return textField
    }

    func makeCoordinator() -> CustomTextField.Coordinator {
        return Coordinator(text: $text)
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CustomTextField>) {
        uiView.text = text
        if isFirstResponder && !context.coordinator.didBecomeFirstResponder  {
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }
    }
}
