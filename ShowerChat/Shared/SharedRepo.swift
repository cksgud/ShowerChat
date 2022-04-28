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
    @Published var ansNum: Int = 0
    
    @Published var btnNum1: Int = 0
    @Published var btnNum2: Int = 1
    @Published var btnNum3: Int = 2
    
    @Published var responses = [String]()
    
    static var sharedVariables = SharedRepo()
}
