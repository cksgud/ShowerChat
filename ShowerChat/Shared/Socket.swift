//
//  Communication.swift
//  ClientApp
//
//  Created by Tristan Ratz on 22.09.19.
//  Copyright © 2019 Tristan Ratz. All rights reserved.
//  Modified by 김찬형 on 2021/09/09.
//

import Foundation

class Socket: NSObject, StreamDelegate {
    let port: Int
    let ipAddress: String
    let textEncoding: String.Encoding

    let connectionTimeout: Double
    var connectionTimer: Timer?
    var inputStreamReady: Bool = false
    var outputStreamReady: Bool = false

    private var inputStream: InputStream!
    private var outputStream: OutputStream!
    private let maxReadLength = 4096

    private var buffer: [Data] = []

    var dataHandler: ((Data, String) -> Void)? // First argument data, second IP
    var stringHandler: ((String, String) -> Void)? // First argument data, second IP

    var connectionCallback: ((Bool) -> Void)?

    init(_ ipAddress: String, _ port: Int, _ textEncoding: String.Encoding) {
        self.port = port
        self.ipAddress = ipAddress
        self.textEncoding = textEncoding
        self.connectionTimeout = 1.0
        
        super.init()
        
        var readStream: Unmanaged<CFReadStream>?
        var writeStream: Unmanaged<CFWriteStream>?
        
        CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, ipAddress as CFString, UInt32(port),
                                           &readStream, &writeStream)
        
        self.inputStream = readStream!.takeRetainedValue()
        self.outputStream = writeStream!.takeRetainedValue()
        
        self.inputStream.delegate = self
        self.outputStream.delegate = self
        
        self.inputStream.schedule(in: .main, forMode: .default)
        self.outputStream.schedule(in: .main, forMode: .default)
        
        print("Establishing connection..!")
    }

    // 소켓 연결
    func connect() {
        self.inputStream.open()
        self.outputStream.open()
        
        print("Establishing connection...")
        
        self.connectionTimer = Timer.scheduledTimer(withTimeInterval: self.connectionTimeout, repeats: false) { _ in
            if !self.inputStreamReady || !self.outputStreamReady {
                print("Timeout \(self.connectionTimeout)s exeeded. Connection failed.")
                if self.connectionCallback != nil {
                    self.connectionCallback?(false)
                }
                self.destroySession()
            } else {
                print("Connection established.")
                if self.connectionCallback != nil {
                    self.connectionCallback?(true)
                }
            }
             self.connectionTimer?.invalidate()
             self.connectionTimer = nil
        }
    }

    func send(data: Data) -> Bool {
        if !outputStream.hasSpaceAvailable {
            print("Loading up buffer...")
            buffer.append(data)
            return false
        }
        
        print("Sending message...")
        data.withUnsafeBytes {
            guard
                let pointer = $0.baseAddress?.assumingMemoryBound(to: UInt8.self)
                else {
                    print("Error sending message")
                    return
                }
            print("Message send: " + String(data: data, encoding: String.Encoding.utf8)!)
            outputStream.write(pointer, maxLength: data.count)
        }
        return true
    }

    func sendText(text: String) {
        #if PROTOCOL_NOJSON
        _ = self.send(data: (text).data(using: textEncoding)!)
        #else
        let stringToServer = SendToServer(text: text)

        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        let dataToServer = try! encoder.encode(stringToServer)
        let jsonToServer = String(data: dataToServer, encoding: .utf8)!
        
        _ = self.send(data: (jsonToServer).data(using: textEncoding)!)
        #endif
    }
    
    private func readAvailableBytes(stream: InputStream) {
      let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: maxReadLength)
      while stream.hasBytesAvailable {
        let numberOfBytesRead = inputStream.read(buffer, maxLength: maxReadLength)
        
        if numberOfBytesRead < 0, let error = stream.streamError {
          print(error)
          break
        }

        if let (data, string) =
            processedMessageString(buffer: buffer, length: numberOfBytesRead) {

            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                #if PROTOCOL_NEWJSON
//                string = """
//                {
//                "chatbot": ["오늘은 기분이 안좋군요", "기분을 한결 좋게 해줄 음악이 있어요", "한번 들어볼래요??"],
//                "buttons": [
//                    {"type": "button", "text": "다음에 들을래요2", "title": "Better together", "artist":"Pate Joans", "src": "src/music/better_together.mp3"}
//                    ]
//                }
//                """
                print("Received Message : ", string)
                SharedRepo.sharedVariables.response_type.removeAll()
                SharedRepo.sharedVariables.chatbot.removeAll()
                SharedRepo.sharedVariables.user_response.removeAll()
                
                let decoder = JSONDecoder()
                guard let serverResponse = try? decoder.decode(ServerResponse.self, from: string.data(using: .utf8)!) else {
                    print("JSON decoding error!")
                    return
                }
                
                if !serverResponse.chatbot.isEmpty {
                    for chatbot in serverResponse.chatbot {
                        SharedRepo.sharedVariables.chatbot.append(chatbot)
                    }
                }
                if !serverResponse.buttons.isEmpty {
                    for buttons in serverResponse.buttons {
                        if buttons.type.contains("button") {
                            SharedRepo.sharedVariables.user_response.append(buttons.text!)
                            SharedRepo.sharedVariables.response_type.append("button")
                        } else if buttons.type.contains("music") {
                            SharedRepo.sharedVariables.user_response.append(buttons.title! + "," + buttons.artist!)
                            SharedRepo.sharedVariables.response_type.append("music")
                        } else if buttons.type.contains("meditation") {
                            SharedRepo.sharedVariables.user_response.append(buttons.text!)
                            SharedRepo.sharedVariables.response_type.append("meditation")
                        } else if buttons.type.contains("diary") {
                            SharedRepo.sharedVariables.user_response.append(buttons.text!)
                            SharedRepo.sharedVariables.response_type.append("diary")
                        }
                    }
                }
                
                if serverResponse.buttons.count > 2 {
                    SharedRepo.sharedVariables.usrRespBtnHorizontal = true
                } else {
                    SharedRepo.sharedVariables.usrRespBtnHorizontal = false
                }
                
                #elseif PROTOCOL_JSON
                // test data
                string = """
                {
                    "type": "button",
                    "chatbot": "안녕하세요? 상담사입니다.",
                    "user_response": [
                        "네 안녕하세요!",
                        "반갑습니다"
                    ]
                }
                """
                SharedRepo.sharedVariables.response_type.removeAll()
                SharedRepo.sharedVariables.chatbot.removeAll()
                SharedRepo.sharedVariables.user_response.removeAll()
                
                let decoder = JSONDecoder()
                guard let serverResponse = try? decoder.decode(ServerResponse.self, from: string.data(using: .utf8)!) else {
                    print("JSON decoding error!")
                    return
                }
                
                if !serverResponse.type.isEmpty {
                    SharedRepo.sharedVariables.response_type = serverResponse.type
                }
                if !serverResponse.chatbot.isEmpty {
                    SharedRepo.sharedVariables.chatbot = serverResponse.chatbot
                }
                if !serverResponse.user_response.isEmpty {
                    for response in serverResponse.user_response {
                        SharedRepo.sharedVariables.user_response.append(response)
                    }
                }
                
                #elseif PROTOCOL_NOJSON
                let serverResponse = string
                let responseParts = serverResponse.split(separator: ":")
                SharedRepo.sharedVariables.chatbot.removeAll()
                SharedRepo.sharedVariables.user_response.removeAll()
                
                if !responseParts.isEmpty {
                    SharedRepo.sharedVariables.chatbot = String(responseParts[0])
                    for i in 1 ..< responseParts.count {
                        SharedRepo.sharedVariables.user_response.append(String(responseParts[i]))
                    }
                }
                #endif
            })
            
            if self.dataHandler != nil {
                self.dataHandler!(data, self.ipAddress)
            }
            if self.stringHandler != nil {
                self.stringHandler!(string, self.ipAddress)
            }
        }
      }
    }

    private func processedMessageString(buffer: UnsafeMutablePointer<UInt8>,
                                        length: Int) -> (Data, String)? {
        guard
            let string = String(
                bytesNoCopy: buffer,
                length: length,
                encoding: textEncoding,
                freeWhenDone: true)
            else {
                return nil
            }
        
        var bytes: [UInt8] = []
        for iterate in 0 ..< length {
            bytes.append(buffer[iterate])
        }
        // Convert to NSData
        let data = NSData(bytes: bytes, length: bytes.count)
      
        return (Data(data), string)
    }

    func destroySession() {
        inputStream.close()
        outputStream.close()
        
        self.inputStreamReady = false
        self.outputStreamReady = false
        self.buffer.removeAll(keepingCapacity: false)
        self.connectionTimer = nil
    }

    func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
        switch eventCode {
        case .hasBytesAvailable:
            readAvailableBytes(stream: aStream as! InputStream)
        case .endEncountered:
            destroySession()
        case .openCompleted:
            if aStream === inputStream {
                print("inputStream opened.")
                self.inputStreamReady = true
            } else {
                print("outputStream opened.")
                self.outputStreamReady = true
            }
        case .errorOccurred:
            print("inputStream: ErrorOccurred: \(aStream.streamError!.localizedDescription)")
        case .hasSpaceAvailable:
            print("Stream has space available")
            if !buffer.isEmpty {
                _ = send(data: self.buffer.removeFirst())
            }
        default:
            print("some other event...")
        }
    }
}

#if PROTOCOL_JSON
struct ServerResponse: Codable {
    var type: String
    var chatbot: String
    var user_response: [String]
}
#elseif PROTOCOL_NEWJSON
struct ServerResponse: Codable {
    var chatbot: [String]
    var buttons: [Buttons]
}
struct Buttons: Codable {
    var type: String
    var text: String?
    var link: String?
    var title: String?
    var artist: String?
}
#endif

struct SendToServer: Codable {
    var text: String
}
