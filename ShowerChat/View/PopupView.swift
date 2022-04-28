//
//  Created by Artem Novichkov on 20.05.2021.
//

import SwiftUI

struct PopupView<Content: View>: View {

    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                content
                    .padding(.bottom, geometry.safeAreaInsets.bottom)
                    .background(Color.white)
                    .cornerRadius(radius: 16, corners: [.topLeft, .topRight, .bottomLeft, .bottomRight])
                Spacer()
            }
            .edgesIgnoringSafeArea([.all])
        }
        .frame(width: 277, height: 284)
        .animation(.easeOut)
    }
}
