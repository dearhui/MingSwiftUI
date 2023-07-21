//
//  SwiftUIView.swift
//  
//
//  Created by minghui on 2022/8/4.
//

import SwiftUI

struct LXSwiftUIPreviews: View {
    var body: some View {
        VStack (spacing: 10) {
            Button("Press Me") {
                print("Button pressed!")
            }
            .buttonStyle(LXGreedyButton(backgroundColor: .yellow))
            LSTextField(placeholder: "帳號", text: .constant(""))
            LSTextField(placeholder: "帳號", text: .constant(""), title: "暱稱", width: 40)
            LSSecureField(placeholder: "密碼", text: .constant("123"), verified: true)
            LSSecureField(title:"密碼", titleWidth: 40 ,placeholder: "密碼", text: .constant("123"), verified: true)
        }
        .padding()
    }
}

struct LXSwiftUIPreviews_Previews: PreviewProvider {
    static var previews: some View {
        LXSwiftUIPreviews()
    }
}
