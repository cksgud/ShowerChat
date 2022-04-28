//
//  PlayRepo.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/09/05.
//

import Foundation

class PlayRepo : ObservableObject {
    @Published var isPlayOn: Bool = false
    static var playShared = PlayRepo()
}
