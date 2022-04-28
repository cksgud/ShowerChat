//
//  PlayRepo.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/09/05.
//

import Foundation

class SharedRepo : ObservableObject {
    @Published var isPlayOn: Bool = true
    @Published var usrRspBtnVisible: Bool = true
    @Published var response_type = ""
    @Published var user_response = [String]()
    @Published var chatbot = ""
    
    static var sharedVariables = SharedRepo()
}
