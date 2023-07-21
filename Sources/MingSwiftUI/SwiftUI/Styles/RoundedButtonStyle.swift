//
//  RoundedButtonStyle.swift
//  eco2
//
//  Created by minghui on 2023/7/21.
//

import SwiftUI

public struct RoundedButtonStyle: ViewModifier {
    let backgroundColor: Color
    let cornerRadius: CGFloat
    
    public init(backgroundColor: Color = Color.accentColor, cornerRadius: CGFloat = 4) {
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
    }

    public func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
    }
}

public extension View {
    func roundedButtonStyle(backgroundColor: Color = Color.accentColor, cornerRadius: CGFloat = 4) -> some View {
        self.modifier(RoundedButtonStyle(backgroundColor: backgroundColor, cornerRadius: cornerRadius))
    }
}

struct RoundedButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, World!")
            .roundedButtonStyle()
            .padding()
    }
}

