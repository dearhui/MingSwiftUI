//
//  StrokedFieldStyle.swift
//  eco2
//
//  Created by minghui on 2023/7/13.
//

import SwiftUI

public struct StrokedFieldStyle: ViewModifier {
    @Environment(\.colorScheme) private var colorSchema
    
    public var strokeColor: Color
    public var backgroundColor: Color?
    public var radius: Double
    public var lineWidth: Double

    public init(strokeColor: Color = .clear, backgroundColor: Color? = nil, radius: Double = 8, lineWidth: Double = 1) {
        self.strokeColor = strokeColor
        self.backgroundColor = backgroundColor
        self.radius = radius
        self.lineWidth = lineWidth
    }

    public func body(content: Content) -> some View {
        content
            .padding()
            .background(
                Rectangle()
                    .foregroundColor(.clear)
                    .background(fieldBackgroundColor)
                    .cornerRadius(radius)
            )
            .overlay(
                RoundedRectangle(cornerRadius: radius)
                    .stroke(strokeColor, lineWidth: CGFloat(lineWidth))
            )
    }
    
    var fieldBackgroundColor: Color {
        if let color = backgroundColor {
            return color
        } else {
            return colorSchema == .dark ?  Color(UIColor.tertiarySystemBackground) : Color(UIColor.systemGroupedBackground)
        }
    }
}

public extension View {
    func strokedFieldStyle(strokeColor: Color = .clear,
                           backgroundColor: Color? = nil,
                           radius: Double = 8,
                           lineWidth: Double = 1) -> some View {
        modifier(StrokedFieldStyle(strokeColor: strokeColor, backgroundColor: backgroundColor, radius: radius, lineWidth: lineWidth))
    }
}

struct StrokedFieldStyle_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TextField("Enter text", text: .constant(""))
                .strokedFieldStyle(strokeColor: .red)
            
            Text("Hello World")
                .strokedFieldStyle(strokeColor: .red, backgroundColor: .green, radius: 12, lineWidth: 3)
        }
        .padding()
    }
}


