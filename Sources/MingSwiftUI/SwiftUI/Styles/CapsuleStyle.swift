//
//  CapsuleStyle.swift
//  
//
//  Created by minghui on 2023/7/23.
//

import SwiftUI

public enum CapsuleStyleType {
    case standard
    case attention
    case tag
    case stroked
    case custom(foregroundColor: Color, backgroundColor: Color?, strokeColor: Color, lineWidth: CGFloat, shadowColor: Color, shadowRadius: CGFloat, shadowOffset: CGSize)
    
    var parameters: (foregroundColor: Color, backgroundColor: Color?, strokeColor: Color, lineWidth: CGFloat, shadowColor: Color, shadowRadius: CGFloat, shadowOffset: CGSize) {
        switch self {
        case .standard:
            return (.primary, nil, .clear, 1, .black.opacity(0.25), 3, CGSize(width: 1, height: 2))
        case .attention:
            return (.white, .accentColor, .clear, 1, .clear, 0, .zero)
        case .tag:
            return (Color(red: 0.05, green: 0.65, blue: 0.91), Color(red: 0.88, green: 0.95, blue: 1), .clear, 1, .clear, 0, .zero)
        case .stroked:
            return (.secondary, .clear, .secondary, 1, .clear, 0, .zero)
        case .custom(let foregroundColor, let backgroundColor, let strokeColor, let lineWidth, let shadowColor, let shadowRadius, let shadowOffset):
            return (foregroundColor, backgroundColor, strokeColor, lineWidth, shadowColor, shadowRadius, shadowOffset)
        }
    }
}

public struct CapsuleStyle: ViewModifier {
    @Environment(\.colorScheme) var colorScheme

    public var style: CapsuleStyleType

    public init(style: CapsuleStyleType = .standard) {
        self.style = style
    }

    public func body(content: Content) -> some View {
        let parameters = style.parameters
        let backgroundColor = parameters.backgroundColor ?? (colorScheme == .dark ? Color.UIKit.secondarySystemBackground : Color.UIKit.systemBackground)
        
        return content
            .foregroundColor(parameters.foregroundColor)
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
    func capsuleStyle(_ style: CapsuleStyleType = .standard) -> some View {
        self.modifier(CapsuleStyle(style: style))
    }
}

struct CapsuleStyleModifier_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("Hello, World!")
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .capsuleStyle(.standard)
            
            Text("Hello, World!")
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .capsuleStyle(.attention)
            
            Text("Hello, World!")
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .capsuleStyle(.tag)

            Text("Hello, World!")
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .capsuleStyle(.stroked)
        }
        .padding()
    }
}



