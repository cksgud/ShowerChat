//
//  LiveVideoControllerAPI.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/10/27.
//

import Foundation
import SwiftUI
import AVKit
import HaishinKit
import AVFoundation
import SystemConfiguration
import Network

let session = AVAudioSession.sharedInstance()
var httpStream = HTTPStream()
var hkView = HKView(frame: .zero)
var httpService = HLSService(domain: "", type: "_http._tcp", name: "HaishinKit", port: 8080)

struct LiveVideo: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        // Pre-Requisites
        do {// https://stackoverflow.com/questions/51010390/avaudiosession-setcategory-swift-4-2-ios-12-play-sound-on-silent
            if #available(iOS 10.0, *) {// 세션 세팅
                try session.setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker, .allowBluetooth])
            } else {
                session.perform(NSSelectorFromString("setCategory:withOptions:error:"), with: AVAudioSession.Category.playAndRecord, with: [
                    AVAudioSession.CategoryOptions.allowBluetooth,
                    AVAudioSession.CategoryOptions.defaultToSpeaker]
                )
                try session.setMode(.default)
            }
            try session.setActive(true)// 세션 활성화
        } catch {
            print(error)
        }
        
        // HTTP Usage
        httpStream.attachCamera(DeviceUtil.device(withPosition: .front))
        httpStream.attachAudio(AVCaptureDevice.default(for: .video))
        httpStream.publish("hello")// HTTP Stream 설정
        
        hkView.attachStream(httpStream)// 뷰에 스트림 연결
        
        httpService.startRunning()// HTTP 서비스 시작
        httpService.addHTTPStream(httpStream)// HTTP 서비스에 HTTP Stream 추가
        
        // 핸드폰 IP 주소 찾기
        let status = ReachabilityStatus()
        var ip_address = ""
        switch status.currentReachabilityStatus {
        case .reachableViaWiFi:
            ip_address = status.getAddress(for: .wifi)!
        case .reachableViaWWAN:
            ip_address = status.getAddress(for: .cellular)!
        default:
            break
        }
        var realIP = ip_address.components(separatedBy: " ")
        if !realIP.isEmpty {
            SharedRepo.sharedVariables.liveInvitationCode = realIP[0]
        }
        realIP.removeAll()
        
        return hkView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}

func getWiFiAddress() -> String? {
    var address: String? // Get list of all interfaces on the local machine:
    var ifaddr: UnsafeMutablePointer<ifaddrs>?
    guard getifaddrs(&ifaddr) == 0 else { return nil }
    guard let firstAddr = ifaddr else { return nil }
    
    // For each interface ...
    for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }){
        let interface = ifptr.pointee
        
        // Check for IPv4 or IPv6 interface:
        let addrFamily = interface.ifa_addr.pointee.sa_family
        if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
            
            // Check interface name:
            let name = String(cString: interface.ifa_name)
            if name == "en0" {
                
                // Convert interface address to a human readable string:
                var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                getnameinfo(
                    interface.ifa_addr,
                    socklen_t(interface.ifa_addr.pointee.sa_len),
                    &hostname, socklen_t(hostname.count),
                    nil,
                    socklen_t(0),
                    NI_NUMERICHOST
                )
                address = String(cString: hostname)
            }
        }
    }
    freeifaddrs(ifaddr)
    return address
}

struct ReachabilityStatus {
    enum status {
        case notReachable
        case reachableViaWWAN
        case reachableViaWiFi
    }
    
    var currentReachabilityStatus: status {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return .notReachable
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return .notReachable
        }
        if flags.contains(.reachable) == false {
            // The target host is not reachable.
            return .notReachable
        } else if flags.contains(.isWWAN) == true {
            // WWAN connections are OK if the calling application is using the CFNetwork APIs.
            return .reachableViaWWAN }
        else if flags.contains(.connectionRequired) == false {
            // If the target host is reachable and no connection is required then we'll assume that you're on Wi-Fi...
            return .reachableViaWiFi
        } else if (flags.contains(.connectionOnDemand) == true ||
                   flags.contains(.connectionOnTraffic) == true) &&
                    flags.contains(.interventionRequired) == false {
            // The connection is on-demand (or on-traffic) if the calling application is using the CFSocketStream or higher APIs and no [user] intervention is needed
            return .reachableViaWiFi
        } else {
            return .notReachable
        }
    }
    
    func getAddress(for network: Network) -> String? {
        var address: String?
        
        // Get list of all interfaces on the local machine:
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else {return nil}
        guard let firstAddr = ifaddr else {return nil}
        
        // For each interface ...
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next}) {
            let interface = ifptr.pointee
            
            // Check for IPv4 or IPv6 interface:
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                
                // Check interface name:
                let name = String(cString: interface.ifa_name)
                if name == network.rawValue {
                    // Convert interface address to a human readable string:
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostname) + " \(name)"
                }
            }
        }
        freeifaddrs(ifaddr)
        
        return address
    }

}

enum Network: String {
    case wifi = "en0"
    case cellular = "pdp_ip0"
}

