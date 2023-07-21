//
//  BorderedArrowStyleModifier.swift
//  eco2
//
//  Created by minghui on 2023/7/21.
//

import SwiftUI

public struct BorderedArrowStyle: ViewModifier {
    let arrowColor: Color
    let strokeColor: Color
    let backgroundColor: Color?
    let radius: Double
    let lineWidth: Double

    public init(strokeColor: Color = Color(red: 0.83, green: 0.83, blue: 0.85), backgroundColor: Color? = nil, arrowColor: Color = .primary, radius: Double = 8, lineWidth: Double = 1) {
        self.strokeColor = strokeColor
        self.backgroundColor = backgroundColor
        self.arrowColor = arrowColor
        self.radius = radius
        self.lineWidth = lineWidth
    }

    public func body(content: Content) -> some View {
        HStack(spacing: 4) {
            content
            
            Image(systemName: "arrowtriangle.down.fill")
                .resizable()
                .frame(width: 10, height: 6)
                .foregroundColor(arrowColor)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .strokedFieldStyle(strokeColor: strokeColor, backgroundColor: backgroundColor, radius: radius, lineWidth: lineWidth)
    }
}

public extension View {
    func borderedArrowStyle(strokeColor: Color = Color(red: 0.83, green: 0.83, blue: 0.85), backgroundColor: Color? = nil, arrowColor: Color = .primary, radius: Double = 8, lineWidth: Double = 1) -> some View {
        self.modifier(BorderedArrowStyle(strokeColor: strokeColor, backgroundColor: backgroundColor, arrowColor: arrowColor, radius: radius, lineWidth: lineWidth))
    }
}

struct BorderedArrowStyleModifier_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("Hello, World!")
                .frame(maxWidth: .infinity, alignment: .leading)
                .borderedArrowStyle(backgroundColor: .clear)
                .padding(.horizontal)
            
            HStack {
                Text("title")
                    .foregroundColor(.primary)
                Spacer()
                Text("description")
                    .foregroundColor(Color.primary)
            }
            .borderedArrowStyle(strokeColor: .clear)
            .padding(.horizontal)
        }
    }
}



