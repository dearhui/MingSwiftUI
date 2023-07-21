//
//  CapsuleStyleModifier.swift
//  
//
//  Created by minghui on 2023/7/21.
//

import SwiftUI

public struct CapsuleStyleModifier: ViewModifier {
    let textColor: Color
    let backgroundColor: Color
    let strokeColor: Color

    public init(textColor: Color, backgroundColor: Color, strokeColor: Color) {
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.strokeColor = strokeColor
    }

    public func body(content: Content) -> some View {
        content
            .foregroundColor(textColor)
            .background(
                Capsule()
                    .stroke(strokeColor, lineWidth: 1)
            )
            .background(backgroundColor)
            .clipShape(Capsule())
    }
}

public extension View {
    func capsuleStyle(textColor: Color = .white, backgroundColor: Color = .accentColor, strokeColor: Color = .clear) -> some View {
        self.modifier(CapsuleStyleModifier(textColor: textColor, backgroundColor: backgroundColor, strokeColor: strokeColor))
    }
}

struct CapsuleStyleModifier_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("Hello, World!")
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .capsuleStyle()

            Text("Hello, World!")
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .capsuleStyle(textColor: .black, backgroundColor: .white, strokeColor: .gray)
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}


