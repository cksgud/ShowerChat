//
//  PlayRepo.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/09/05.
//

import AVKit

class SharedRepo : ObservableObject {
    @Published var isShowOn: Bool = true
    @Published var onAppearNumber : Double = 1.0
    @Published var usrRespBtnHorizontal: Bool = false
    @Published var chatbot = [String]()
    @Published var response_type = [String]()
    @Published var user_response = [String]()
    @Published var user_response_count: Int = 0
    @Published var audioPlayer: AVAudioPlayer!
    @Published var musicPath = Bundle.main.path(forResource: "Bluebird_BumyGoldson", ofType: "mp3")
    @Published var musicPlayerOn = false
    @Published var onelineDiaryOn = false
    @Published var onelineDiaryWritten: Bool = false
    @Published var diaryData = [String]()
    @Published var letterWritten: Bool = false
    @Published var meditationDone: Bool = false
    @Published var liveChattingText = [String]()
    @Published var dayDatesData = [String]()
    @Published var dayOfTheWeek = [String]()
    @Published var dayOfToday : String = ""
    @Published var user_response_picked : String = ""
    @Published var main_mission_selected : String = ""
    @Published var liveInvitationCode : String = ""
    @Published var liveURL : String = "https://manifest.googlevideo.com/api/manifest/hls_variant/expire/1634758367/ei/fxpwYZibFZGC2roP1LyMoAM/ip/175.123.221.109/id/e1zXW_TFLkQ.1/source/yt_live_broadcast/requiressl/yes/hfr/1/ctier/A/playlist_duration/30/manifest_duration/30/maxh/2160/maudio/1/hightc/yes/vprv/1/go/1/nvgoi/1/keepalive/yes/fexp/24001373%2C24007246/dover/11/itag/0/playlist_type/DVR/sparams/expire%2Cei%2Cip%2Cid%2Csource%2Crequiressl%2Chfr%2Cctier%2Cplaylist_duration%2Cmanifest_duration%2Cmaxh%2Cmaudio%2Chightc%2Cvprv%2Cgo%2Citag%2Cplaylist_type/sig/AOq0QJ8wRgIhAOgq6h8DG3ttj0L83Ju0PjbJy0j_EYM7k3qp69GLN8V2AiEA89lsTJiXcYr5skw_Tc5iH6zS_klz6Ej3JhQTX7siHfE%3D/file/index.m3u8"
    
    #if PROTOCOL_LOCAL
    @Published var chatbot_answer_count: Int = 0
    @Published var user_response_data = [String]()
    #endif
    
    static var sharedVariables = SharedRepo()
}

class VideoRepo : ObservableObject {
    @Published var smartVideoPlayer = SmartPlayerUIView(frame: .zero)
    
    static var sharedVideos = VideoRepo()
}
