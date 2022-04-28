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
    static var sharedVariables = SharedRepo()
}
