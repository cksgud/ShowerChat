import SwiftUI
import Combine

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
