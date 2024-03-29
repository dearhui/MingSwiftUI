//
//  File.swift
//  
//
//  Created by minghui on 2023/7/21.
//

import SwiftUI

public enum RoundedBackgroundStyleType {
    case standard // card
    case stroked
    case button
    case buttonColor(Color)
    case field
    case fieldError
    case custom(darkBackgroundColor: Color?, lightBackgroundColor: Color?, strokeColor: Color, radius: CGFloat, lineWidth: CGFloat, shadowColor: Color, shadowRadius: CGFloat, shadowOffset: CGSize)

    var parameters: (darkBackgroundColor: Color?, lightBackgroundColor: Color?, strokeColor: Color, radius: CGFloat, lineWidth: CGFloat, shadowColor: Color, shadowRadius: CGFloat, shadowOffset: CGSize) {
        switch self {
        case .standard:
            return (.UIKit.tertiarySystemBackground, .UIKit.systemBackground, .clear, 6, 1, .black.opacity(0.25), 3, CGSize(width: 1, height: 2))
        case .stroked:
            return (.UIKit.tertiarySystemBackground, .UIKit.systemBackground, .UIKit.separator, 6, 1, .clear, 3, .zero)
        case .button:
            return (.accentColor, .accentColor, .clear, 6, 1, .clear, 0, .zero)
        case .buttonColor(let background):
            return (background, background, .clear, 6, 1, .clear, 0, .zero)
        case .field:
            return (.UIKit.tertiarySystemBackground, .UIKit.systemGroupedBackground, .clear, 6, 1, .clear, 0, .zero)
        case .fieldError:
            return (.UIKit.tertiarySystemBackground, .UIKit.systemGroupedBackground, .pink, 6, 1, .clear, 0, .zero)
        case .custom(let darkBackgroundColor, let lightBackgroundColor, let strokeColor, let radius, let lineWidth, let shadowColor, let shadowRadius, let shadowOffset):
            return (darkBackgroundColor, lightBackgroundColor, strokeColor, radius, lineWidth, shadowColor, shadowRadius, shadowOffset)
        }
    }
}

public struct RoundedBackgroundStyle: ViewModifier {
    @Environment(\.colorScheme) var colorScheme

    public var style: RoundedBackgroundStyleType

    public init(style: RoundedBackgroundStyleType = .standard) {
        self.style = style
    }

    public func body(content: Content) -> some View {
        let parameters = style.parameters
        let backgroundColor = (colorScheme == .dark ? parameters.darkBackgroundColor : parameters.lightBackgroundColor) ?? Color(UIColor.secondarySystemBackground)

        return content
            .background(
                RoundedRectangle(cornerRadius: parameters.radius)
                    .foregroundColor(backgroundColor)
                    .shadow(color: parameters.shadowColor, radius: parameters.shadowRadius, x: parameters.shadowOffset.width, y: parameters.shadowOffset.height)
            )
            .overlay(
                RoundedRectangle(cornerRadius: parameters.radius)
                    .stroke(parameters.strokeColor, lineWidth: parameters.lineWidth)
            )
    }
}

public extension View {
    func roundedBackgroundStyle(_ style: RoundedBackgroundStyleType = .standard) -> some View {
        self.modifier(RoundedBackgroundStyle(style: style))
    }
}

struct RoundedBackgroundStyleModifier_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("Hello, World!\nHello, World!")
                .padding()
                .roundedBackgroundStyle(.standard)
            
            Text("Hello, World!\nHello, World!")
                .padding()
                .roundedBackgroundStyle(.stroked)

            Text("Hello, World!")
                .foregroundColor(.white)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
                .roundedBackgroundStyle(.button)
            
            Text("Hello, World!")
                .foregroundColor(.white)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
                .roundedBackgroundStyle(.buttonColor(.yellow))
            
            TextField("Please Input text", text: .constant(""))
                .padding()
                .roundedBackgroundStyle(.field)
            
            TextField("Please Input text", text: .constant(""))
                .padding()
                .roundedBackgroundStyle(.fieldError)
        }
        .padding()
    }
}
