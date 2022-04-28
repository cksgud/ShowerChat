//
//  MentalVideoController.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/10/11.
//

import SwiftUI
import AVKit
import AVFoundation

#if PROTOCOL_LOCAL
let time_delay_insert = 1.1
let time_delay_play = 1.5
#else
let time_delay_insert = 2.0
let time_delay_play = 2.5
#endif

func playNextSmartly(goNext: Binding<Bool>) {
    goNext.wrappedValue.toggle()
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time_delay_play) {
        VideoRepo.sharedVideos.smartVideoPlayer.queuePlayer.pause()
        goNext.wrappedValue.toggle()
        VideoRepo.sharedVideos.smartVideoPlayer.queuePlayer.advanceToNextItem()
        VideoRepo.sharedVideos.smartVideoPlayer.queuePlayer.play()
    }
}

struct SmartVideoPlayer: UIViewRepresentable {
    @Binding var goNext: Bool
    func makeUIView(context: Context) -> UIView {
        return VideoRepo.sharedVideos.smartVideoPlayer
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        if goNext {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time_delay_insert) {
                print("SharedRepo.sharedVariables.chatbot = ", SharedRepo.sharedVariables.chatbot)
                if !SharedRepo.sharedVariables.chatbot.isEmpty {
                    if SharedRepo.sharedVariables.chatbot[0].contains("안녕하세요") {
                        VideoRepo.sharedVideos.smartVideoPlayer.queuePlayer.insert(AVPlayerItem(url:  Bundle.main.url(forResource: "mentalcare_01_01", withExtension: "mp4")!), after: nil)
                    } else if SharedRepo.sharedVariables.chatbot[0].contains("기분이 안 좋았군요") {
                        VideoRepo.sharedVideos.smartVideoPlayer.queuePlayer.insert(AVPlayerItem(url:  Bundle.main.url(forResource: "mentalcare_01_02", withExtension: "mp4")!), after: nil)
                    } else if SharedRepo.sharedVariables.chatbot[0].contains("기분을 한결 좋게 해줄 음악") {
                        VideoRepo.sharedVideos.smartVideoPlayer.queuePlayer.insert(AVPlayerItem(url:  Bundle.main.url(forResource: "mentalcare_01_03", withExtension: "mp4")!), after: nil)
                    } else if SharedRepo.sharedVariables.chatbot[0].contains("음악을 듣고") {
                        VideoRepo.sharedVideos.smartVideoPlayer.queuePlayer.insert(AVPlayerItem(url:  Bundle.main.url(forResource: "mentalcare_01_04", withExtension: "mp4")!), after: nil)
                    } else if SharedRepo.sharedVariables.chatbot[0].contains("당신에게 들려주고 싶은 이야기") {
                        VideoRepo.sharedVideos.smartVideoPlayer.queuePlayer.insert(AVPlayerItem(url:  Bundle.main.url(forResource: "mentalcare_01_05", withExtension: "mp4")!), after: nil)
                    } else if SharedRepo.sharedVariables.chatbot[0].contains("우리의 감정도 날씨와 비슷") {
                        VideoRepo.sharedVideos.smartVideoPlayer.queuePlayer.insert(AVPlayerItem(url:  Bundle.main.url(forResource: "mentalcare_01_06", withExtension: "mp4")!), after: nil)
                    } else if SharedRepo.sharedVariables.chatbot[0].contains("오늘처럼") {
                        VideoRepo.sharedVideos.smartVideoPlayer.queuePlayer.insert(AVPlayerItem(url:  Bundle.main.url(forResource: "mentalcare_01_07", withExtension: "mp4")!), after: nil)
                    } else if SharedRepo.sharedVariables.chatbot[0].contains("친한 친구와") {
                        VideoRepo.sharedVideos.smartVideoPlayer.queuePlayer.insert(AVPlayerItem(url:  Bundle.main.url(forResource: "mentalcare_01_08", withExtension: "mp4")!), after: nil)
                    } else if SharedRepo.sharedVariables.chatbot[0].contains("좋아요.") {
                        VideoRepo.sharedVideos.smartVideoPlayer.queuePlayer.insert(AVPlayerItem(url:  Bundle.main.url(forResource: "mentalcare_01_09", withExtension: "mp4")!), after: nil)
                    } else if SharedRepo.sharedVariables.chatbot[0].contains("어린왕자") {
                        VideoRepo.sharedVideos.smartVideoPlayer.queuePlayer.insert(AVPlayerItem(url:  Bundle.main.url(forResource: "mentalcare_01_10", withExtension: "mp4")!), after: nil)
                    } else if SharedRepo.sharedVariables.chatbot[0].contains("우울한 기분이") {
                        VideoRepo.sharedVideos.smartVideoPlayer.queuePlayer.insert(AVPlayerItem(url:  Bundle.main.url(forResource: "mentalcare_01_11", withExtension: "mp4")!), after: nil)
                    }  else if SharedRepo.sharedVariables.chatbot[0].contains("오늘의 우울했던") {
                        VideoRepo.sharedVideos.smartVideoPlayer.queuePlayer.insert(AVPlayerItem(url:  Bundle.main.url(forResource: "mentalcare_01_12", withExtension: "mp4")!), after: nil)
                    } else if SharedRepo.sharedVariables.chatbot[0].contains("다행이에요") {
                        VideoRepo.sharedVideos.smartVideoPlayer.queuePlayer.insert(AVPlayerItem(url:  Bundle.main.url(forResource: "mentalcare_01_13", withExtension: "mp4")!), after: nil)
                    } else {
                        VideoRepo.sharedVideos.smartVideoPlayer.queuePlayer.insert(AVPlayerItem(url:  Bundle.main.url(forResource: "mentalcare_idle", withExtension: "mp4")!), after: nil)
                    }
                } else {
                    VideoRepo.sharedVideos.smartVideoPlayer.queuePlayer.insert(AVPlayerItem(url:  Bundle.main.url(forResource: "mentalcare_idle", withExtension: "mp4")!), after: nil)
                }
            }
        }
    }
}

class SmartPlayerUIView: UIView {
    private var playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?
    var queuePlayer = AVQueuePlayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let mentalVideos : [AVPlayerItem] = [
            AVPlayerItem(url:  Bundle.main.url(forResource: "mentalcare_01_01", withExtension: "mp4")!),
        ]
        
        queuePlayer = AVQueuePlayer(items: mentalVideos)
        playerLayer.player = queuePlayer
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        
        queuePlayer.play()
        
        queuePlayer.actionAtItemEnd = .pause
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//struct MentalVideosPlayer: UIViewRepresentable {
//    @Binding var goNext: Bool
//    func makeUIView(context: Context) -> UIView {
//        return SharedRepo.sharedVariables.mentalVideoPlayer
//    }
//    
//    func updateUIView(_ uiView: UIView, context: Context) {
//        if goNext {
//            SharedRepo.sharedVariables.mentalVideoPlayer.queuePlayer.advanceToNextItem()
//            SharedRepo.sharedVariables.mentalVideoPlayer.queuePlayer.play()
//        }
//    }
//}

class QueuePlayerUIView: UIView {
    private var playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?
    var queuePlayer = AVQueuePlayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Load Video
        let mentalVideos : [AVPlayerItem] = [
            AVPlayerItem(url:  Bundle.main.url(forResource: "mentalcare_01_01", withExtension: "mp4")!),
            AVPlayerItem(url:  Bundle.main.url(forResource: "mentalcare_01_02", withExtension: "mp4")!),
            AVPlayerItem(url:  Bundle.main.url(forResource: "mentalcare_01_03", withExtension: "mp4")!),
            AVPlayerItem(url:  Bundle.main.url(forResource: "mentalcare_01_04", withExtension: "mp4")!),
            AVPlayerItem(url:  Bundle.main.url(forResource: "mentalcare_01_05", withExtension: "mp4")!),
            AVPlayerItem(url:  Bundle.main.url(forResource: "mentalcare_01_06", withExtension: "mp4")!),
            AVPlayerItem(url:  Bundle.main.url(forResource: "mentalcare_01_07", withExtension: "mp4")!),
            AVPlayerItem(url:  Bundle.main.url(forResource: "mentalcare_01_08", withExtension: "mp4")!),
            AVPlayerItem(url:  Bundle.main.url(forResource: "mentalcare_01_09", withExtension: "mp4")!),
            AVPlayerItem(url:  Bundle.main.url(forResource: "mentalcare_01_10", withExtension: "mp4")!),
            AVPlayerItem(url:  Bundle.main.url(forResource: "mentalcare_01_11", withExtension: "mp4")!),
            AVPlayerItem(url:  Bundle.main.url(forResource: "mentalcare_01_12", withExtension: "mp4")!),
            AVPlayerItem(url:  Bundle.main.url(forResource: "mentalcare_01_13", withExtension: "mp4")!),
            AVPlayerItem(url:  Bundle.main.url(forResource: "mentalcare_01_14", withExtension: "mp4")!),
        ]
        
        // Setup Player
        queuePlayer = AVQueuePlayer(items: mentalVideos)
        playerLayer.player = queuePlayer
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        
        // Play
        queuePlayer.play()
        
        queuePlayer.actionAtItemEnd = .pause
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct AVPlayerView: UIViewControllerRepresentable {
    var player: AVPlayer

    func updateUIViewController(_ playerController: AVPlayerViewController, context: Context) {
        playerController.showsPlaybackControls = false
        playerController.modalPresentationStyle = .fullScreen
        playerController.player = player
        
        playerController.player?.play()

    }

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        return AVPlayerViewController()
    }
}
