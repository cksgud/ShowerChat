//
//  MusicPlayer.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/09/28.
//

import SwiftUI
import AVKit

struct MusicPlayer: View {
    @EnvironmentObject private var clientSocket: Connection
    var musicPath = Bundle.main.path(forResource: "Bluebird_BumyGoldson", ofType: "mp3")
    var audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "Bluebird_BumyGoldson", ofType: "mp3")!))
    @State var playFlag = false
    @Binding var goNext: Bool
    
    var body: some View {
        HStack {
            VStack {
                Text("Better Together").padding(.leading, 35)
                    .font(Font.custom("AppleSDGothicNeo-Bold", size: 18))
                Text("Pate Jonas")
                    .font(Font.custom("AppleSDGothicNeo-Light", size: 14))
                    .offset(x: -15)
            }
            Spacer()
            if playFlag {
                Image(systemName: "pause").padding(.trailing, 20)
                    .onTapGesture {
                        audioPlayer.pause()
                        playFlag.toggle()
                    }
            } else {
                Image(systemName: "play.fill").padding(.trailing, 20)
                    .onTapGesture {
                        audioPlayer.play()
                        playFlag.toggle()
                    }
            }
            Image(systemName: "xmark").padding(.trailing, 20)
                .onTapGesture {
                    goNext.toggle()
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                        goNext.toggle()
                    }
                    SharedRepo.sharedVariables.response_type.removeAll()
                    #if PROTOCOL_LOCAL
                    SharedRepo.sharedVariables.user_response_data.removeAll()
                    #else
                    SharedRepo.sharedVariables.user_response.removeAll()
                    SharedRepo.sharedVariables.musicPlayerOn.toggle()
                    clientSocket.send(message: "음악재생종료")
                    #endif
                    SharedRepo.sharedVariables.user_response_picked.removeAll()
                    SharedRepo.sharedVariables.user_response_count += 1
                }
        }
        .background(
            Rectangle()
                .fill(Color.black.opacity(0.5))
                .frame(width: UIScreen.main.bounds.width, height: 80)
                .edgesIgnoringSafeArea(.bottom)
        )
        .foregroundColor(.white)
        .padding(.top, 30)
    }
}
