//
//  MentalVideoController.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/10/11.
//

import SwiftUI
import AVKit
import AVFoundation

struct MentalVideosPlayer: UIViewRepresentable {
    @Binding var goNext: Bool
    func makeUIView(context: Context) -> UIView {
        return SharedRepo.sharedVariables.mentalVideoPlayer
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        if goNext {
            SharedRepo.sharedVariables.mentalVideoPlayer.queuePlayer.advanceToNextItem()
            SharedRepo.sharedVariables.mentalVideoPlayer.queuePlayer.play()
        }
    }
}

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
