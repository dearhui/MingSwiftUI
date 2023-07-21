//
//  LSRoudedRectangleButtonModifier.swift
//  eco2
//
//  Created by minghui on 2021/12/24.
//

import SwiftUI

public struct LSRoudedRectangleButtonModifier: ViewModifier {
    
    var font: Color = .white
    var boder: Color = .clear
    var background: Color = .accentColor

    public init(font: Color = .white, boder: Color = .clear, background: Color = .accentColor) {
        self.font = font
        self.boder = boder
        self.background = background
    }
    
    public func body(content: Content) -> some View {
        content
            .font(.system(size: 18, weight: .bold))
            .foregroundColor(font)
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 44)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(boder, lineWidth: 2) // 有邊線
            )
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(background)
            )
    }
}

struct LSModifyPreview: PreviewProvider {
    static var previews: some View {
        VStack {
            
            Text("Hello World")
                .modifier(LSRoudedRectangleButtonModifier())
            
            Text("Hello World")
                .modifier(LSRoudedRectangleButtonModifier(font: .accentColor,
                                                          background: .white))
            
            Text("Hello World")
                .modifier(LSRoudedRectangleButtonModifier(font: .blue,
                                                          boder: .red,
                                                          background: .green))
        }
        .padding()
    }
}
