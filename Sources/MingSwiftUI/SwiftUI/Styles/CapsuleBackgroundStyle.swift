//
//  CapsuleBackgroundStyle.swift
//  
//
//  Created by minghui on 2023/7/23.
//

import SwiftUI

public enum CapsuleBackgroundStyleType {
    case standard
    case emphasized
    case custom(backgroundColor: Color?, strokeColor: Color, lineWidth: CGFloat, shadowColor: Color, shadowRadius: CGFloat, shadowOffset: CGSize)
    
    var parameters: (backgroundColor: Color?, strokeColor: Color, lineWidth: CGFloat, shadowColor: Color, shadowRadius: CGFloat, shadowOffset: CGSize) {
        switch self {
        case .standard:
            return (nil, .clear, 1, .black.opacity(0.25), 3, CGSize(width: 1, height: 2))
        case .emphasized:
            return (.accentColor, .clear, 1, .clear, 0, .zero)
        case .custom(let backgroundColor, let strokeColor, let lineWidth, let shadowColor, let shadowRadius, let shadowOffset):
            return (backgroundColor, strokeColor, lineWidth, shadowColor, shadowRadius, shadowOffset)
        }
    }
}

public struct CapsuleBackgroundStyle: ViewModifier {
    @Environment(\.colorScheme) var colorScheme

    public var style: CapsuleBackgroundStyleType

    public init(style: CapsuleBackgroundStyleType = .standard) {
        self.style = style
    }

    public func body(content: Content) -> some View {
        let parameters = style.parameters
        let backgroundColor = parameters.backgroundColor ?? (colorScheme == .dark ? Color.secondarySystemBackground : Color.systemBackground)
        
        return content
            .background(
                Capsule()
                    .foregroundColor(backgroundColor)
                    .shadow(color: parameters.shadowColor, radius: parameters.shadowRadius, x: parameters.shadowOffset.width, y: parameters.shadowOffset.height)
            )
            .overlay(
                Capsule()
                    .stroke(parameters.strokeColor, lineWidth: parameters.lineWidth)
            )
    }
}

public extension View {
    func capsuleBackgroundStyle(style: CapsuleBackgroundStyleType = .standard) -> some View {
        self.modifier(CapsuleBackgroundStyle(style: style))
    }
}


struct CapsuleBackgroundStyleModifier_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("Hello, World!")
                .foregroundColor(.white)
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .capsuleBackgroundStyle(style: .emphasized)
                
            Text("Hello, World!")
                .foregroundColor(.primary)
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .capsuleBackgroundStyle(style: .standard)
        }
        .padding()
    }
}


