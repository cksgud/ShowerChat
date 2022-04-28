//
//  Connection.swift
//  ClientApp
//
//  Created by Tristan Ratz on 03.10.19.
//  Copyright © 2019 Tristan Ratz. All rights reserved.
//  Modified by 김찬형 on 2021/09/09.
//

import SwiftUI
import Combine

// Socket.swift 기반으로 실제 활용 가능한 API
class Connection: ObservableObject {

    @Published var askForName: Bool = false
    @Published var failedToConnect: Bool = false

    @Published var userNameRejected: Bool = false

    @Published var emptyFields: Bool = false
    @Published var emptyNameField: Bool = false

    var connected: Bool = false
    var name: String
    
    var socket: Socket?

    @Published var keyboardHeight: CGFloat = 0

    init() {
//        self.controller = delegate
        self.name = ""

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
    }

    // 소켓 연결
    func connect(ip: String, port: Int) {
        if socket != nil {
            socket!.destroySession()
        }
        self.socket = Socket(ip, port, .utf8)
        self.socket!.connectionCallback = didConnect
        self.socket!.connect()
        print("connected")
    }

    // 소켓 연결 성공/실패 시 기록 저장
    func didConnect(_ success: Bool) {
        if success {
            self.connected = true
            self.askForName = true
        } else {
            print("Failed")
            self.failedToConnect = true
        }
    }

//    func login(name: String) {
//        self.name = name
//        socket!.stringHandler = loginCallback
//        socket!.sendText(text: name)
//    }
//
//    func loginCallback(reply: String, ip: String) {
//        print("Logincallback: ", reply)
//        if reply == "server:msg:Welcome, \(self.name)!" {
//            self.askForName = false
////            controller.connected()
//        } else if reply == "server:inf:name" {
//            self.askForName = true
//            self.userNameRejected = true
//        }
//    }

    // 메시지 전송
    func send(message: String) {
        socket!.sendText(text: self.name + message)
    }

    // 소켓 연결 해제
    func disconnect() {
        self.connected = false
        self.socket!.destroySession()
        self.name = ""
    }

    func toggleFailed() {
        self.failedToConnect.toggle()
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                keyboardHeight = keyboardRectangle.height
        }
    }
}
