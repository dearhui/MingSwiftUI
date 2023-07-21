//
//  StrokedFieldStyle.swift
//  eco2
//
//  Created by minghui on 2023/7/13.
//

import SwiftUI

public struct StrokedFieldStyleModifier: ViewModifier {
    @Environment(\.colorScheme) private var colorSchema
    
    public var isStroke: Bool
    public var strokeColor: Color

    private let radius: Double = 8
    private let backgroundColorLight: Color = Color(UIColor.systemGroupedBackground)
    private let backgroundColorDark: Color = Color(UIColor.tertiarySystemBackground)
    private let lineWidth: Double = 1

    public init(isStroke: Bool, strokeColor: Color) {
        self.isStroke = isStroke
        self.strokeColor = strokeColor
    }

    public func body(content: Content) -> some View {
        content
            .padding()
            .background(
                Rectangle()
                    .foregroundColor(.clear)
                    .background(colorSchema == .dark ?  backgroundColorDark : backgroundColorLight)
                    .cornerRadius(radius)
            )
            .overlay(
                RoundedRectangle(cornerRadius: radius)
                    .stroke(isStroke ? strokeColor : .clear, lineWidth: lineWidth)
            )
    }
}

public extension View {
    func strokedFieldStyle(isStroke: Bool = false, strokeColor: Color = Color(UIColor.systemPink)) -> some View {
        modifier(StrokedFieldStyleModifier(isStroke: isStroke, strokeColor: strokeColor))
    }
}

struct StrokedFieldStyle_Previews: PreviewProvider {
    static var previews: some View {
        TextField("Enter text", text: .constant(""))
                    .strokedFieldStyle(isStroke: true, strokeColor: .red)
                    .padding()
    }
}
