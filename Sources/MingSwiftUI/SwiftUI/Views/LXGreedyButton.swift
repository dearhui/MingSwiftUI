//
//  LXGreedyButton.swift
//  
//
//  Created by minghui on 2022/8/4.
//

import SwiftUI

public struct LXGreedyButton: ButtonStyle {
    
    public init(textColor: Color = .white, backgroundColor: Color = .accentColor) {
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }
    
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    private var textColor: Color
    private var backgroundColor: Color
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 18, weight: .bold, design: .default))
            .foregroundColor(textColor)
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .background(configuration.isPressed ? backgroundColor.opacity(0.5) : (isEnabled ? backgroundColor : Color.gray.opacity(0.5)))
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
