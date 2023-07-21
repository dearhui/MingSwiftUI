//
//  BorderedArrowStyleModifier.swift
//  eco2
//
//  Created by minghui on 2023/7/21.
//

import SwiftUI

public struct BorderedArrowStyle: ViewModifier {
    let backgroundColor: Color
    let strokeColor: Color
    let arrowColor: Color
    
    public init(backgroundColor: Color = .clear, strokeColor: Color = Color(red: 0.83, green: 0.83, blue: 0.85), arrowColor: Color = .primary) {
        self.backgroundColor = backgroundColor
        self.strokeColor = strokeColor
        self.arrowColor = arrowColor
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
        .padding()
        .background(
            Rectangle()
                .foregroundColor(backgroundColor)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(strokeColor, lineWidth: 1)
                )
        )
    }
}

public extension View {
    func borderedArrowStyle(backgroundColor: Color = .clear, strokeColor: Color = Color(red: 0.83, green: 0.83, blue: 0.85), arrowColor: Color = .primary) -> some View {
        self.modifier(BorderedArrowStyle(backgroundColor: backgroundColor, strokeColor: strokeColor, arrowColor: arrowColor))
    }
}

struct BorderedArrowStyleModifier_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("Hello, World!")
                .frame(maxWidth: .infinity, alignment: .leading)
                .borderedArrowStyle()
                .padding(.horizontal)
            
            HStack {
                Text("title")
                    .foregroundColor(.primary)
                Spacer()
                Text("description")
                    .foregroundColor(Color.primary)
            }
            .borderedArrowStyle()
            .padding(.horizontal)
        }
    }
}

