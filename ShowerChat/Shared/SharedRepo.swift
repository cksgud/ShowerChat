//
//  PlayRepo.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/09/05.
//

import AVKit

class SharedRepo : ObservableObject {
    @Published var mentalVideoPlayer = QueuePlayerUIView(frame: .zero)
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
    @Published var diaryData = [String]()
    @Published var user_response_picked : String = ""
    @Published var main_mission_selected : String = ""
    
    #if PROTOCOL_LOCAL
    @Published var chatbot_answer_count: Int = 0
    @Published var user_response_data = [String]()
    #endif
    
    static var sharedVariables = SharedRepo()
}
