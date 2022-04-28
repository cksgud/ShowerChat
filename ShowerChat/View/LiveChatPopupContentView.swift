//
//  Created by Artem Novichkov on 20.05.2021.
//

import SwiftUI

struct LiveChatPopupContentView: View {
    @Binding var isPresented: Bool
    @Binding var text: String
    @Binding var moveToScreen: String?
    
    var body: some View {
        VStack {
            Text("""
            Live Chat을 참여하려면
            초대 코드가 필요합니다.
            초대코드를 입력해 주세요
            """)
                .font(Font.custom("AppleSDGothicNeo-SemiBold", size: 16))
                .frame(width: 161, height: 90)
                .multilineTextAlignment(.center)
            
            TextField("초대코드", text: $text)
                .font(Font.custom("AppleSDGothicNeo-Regular", size: 16))
                .frame(width: 234, height: 39)
                .padding([.leading, .trailing], 10)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
            
            Spacer().frame(width: 0, height: 1)
            
            HStack {
                Spacer()
                
                Button(action: {
                    isPresented = false
                }, label: {
                    Text("취소")
                        .font(Font.custom("AppleSDGothicNeo-Regular", size: 16))
                })
                .frame(width: 80, height: 36)
                .foregroundColor(.black)
                .cornerRadius(10)
                
                Spacer()
                
                Button(action: {
                    isPresented = false
                    if text != "" {
                        SharedRepo.sharedVariables.liveInvitationCode = "http://"
                        SharedRepo.sharedVariables.liveInvitationCode.append(text)
                        SharedRepo.sharedVariables.liveInvitationCode.append(":8080/hello/playlist.m3u8")
                        text = SharedRepo.sharedVariables.liveInvitationCode
                        
                        var codes = SharedRepo.sharedVariables.liveInvitationCode.components(separatedBy: ":")
                        var slash_code = codes[1].components(separatedBy: "//")
                        var real_code = slash_code[1]
                        SharedRepo.sharedVariables.liveInvitationCode = real_code
                    }
                    moveToScreen = "livechat"
                }, label: {
                    Text("확인")
                        .font(Font.custom("AppleSDGothicNeo-SemiBold", size: 16))
                })
                .frame(width: 80, height: 36)
                .foregroundColor(.black)
                .cornerRadius(10)
                
                Spacer()
            }
        }
        .padding()
        
    }
}
