//
//  ButtonAPI.swift
//  ShowerChat
//
//  Created by 김찬형 on 2021/10/13.
//

import SwiftUI
import Foundation

#if PROTOCOL_LOCAL
func actionForButton(userResponse: String, clientSocket: Connection) {
    SharedRepo.sharedVariables.response_type.removeAll()
    SharedRepo.sharedVariables.user_response_data.removeAll()
    SharedRepo.sharedVariables.user_response_data.append(userResponse)
    SharedRepo.sharedVariables.user_response_picked = userResponse
    
    #if Melissa
    // BUTTON LINK
    if userResponse.contains("좋아요") || userResponse.contains("보통이에요") ||
        userResponse.contains("괜찮아요") || userResponse.contains("다음에 들을게요") || userResponse.contains("그저 그래요") {
        SharedRepo.sharedVariables.chatbot_answer_count = 4
        SharedRepo.sharedVariables.user_response_count = 5
    } else if userResponse.contains("가족과 시간 보내기") || userResponse.contains("대화 이어가기") {
        SharedRepo.sharedVariables.chatbot_answer_count = 9
        SharedRepo.sharedVariables.user_response_count = 10
    } else {
        SharedRepo.sharedVariables.user_response_count += 1
    }
    print("SharedRepo.sharedVariables.user_response_count = ", SharedRepo.sharedVariables.user_response_count)
    #else
    // BUTTON LINK
    if userResponse == "좋아" || userResponse.contains("보통") ||
        userResponse.contains("괜찮아") || userResponse.contains("다음에 들을게") || userResponse.contains("그저 그래") {
        SharedRepo.sharedVariables.chatbot_answer_count = 4
        SharedRepo.sharedVariables.user_response_count = 5
    } else if userResponse.contains("가족과 시간 보내기") || userResponse.contains("대화 이어가기") {
        SharedRepo.sharedVariables.chatbot_answer_count = 9
        SharedRepo.sharedVariables.user_response_count = 10
    } else {
        SharedRepo.sharedVariables.user_response_count += 1
    }
    print("SharedRepo.sharedVariables.user_response_count = ", SharedRepo.sharedVariables.user_response_count)
    #endif
}

#else
func actionForButton(userResponse: String, responseType: String, clientSocket: Connection) {
    SharedRepo.sharedVariables.user_response.removeAll()
    SharedRepo.sharedVariables.user_response.append(userResponse)
    if responseType.contains("music") {
        SharedRepo.sharedVariables.musicPlayerOn.toggle()
        SharedRepo.sharedVariables.chatbot.removeAll()
        SharedRepo.sharedVariables.response_type.removeAll()
    } else if responseType.contains("diary") {
        SharedRepo.sharedVariables.onelineDiaryOn.toggle()
        SharedRepo.sharedVariables.chatbot.removeAll()
        SharedRepo.sharedVariables.response_type.removeAll()
    } else {
        clientSocket.send(message: userResponse)
    }
    
    SharedRepo.sharedVariables.user_response_count += 1
}
#endif
