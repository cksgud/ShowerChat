//
//  ShowerChatApp.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/09/02.
//

import SwiftUI

var dayDates = Date().getDayDate()

@main
struct ShowerChatApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
