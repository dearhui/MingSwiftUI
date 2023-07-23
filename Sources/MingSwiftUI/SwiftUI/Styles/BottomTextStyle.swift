//
//  BottomTextStyle.swift
//  
//
//  Created by minghui on 2023/7/23.
//

import SwiftUI

public struct BottomTextStyle: ViewModifier {
    let text: String
    let color: Color
    let alignment: HorizontalAlignment
    let spacing: CGFloat

    public init(_ text: String = "", color: Color = .pink, alignment: HorizontalAlignment = .leading, spacing: CGFloat = 4) {
        self.text = text
        self.color = color
        self.alignment = alignment
        self.spacing = spacing
    }
    
    public func body(content: Content) -> some View {
        VStack(alignment: alignment, spacing: spacing) {
            content
            
            if !text.isEmpty {
                Text(LocalizedStringKey(text))
                    .font(.footnote)
                    .foregroundColor(color)
            }
        }
    }
}

public extension View {
    func bottomText(_ text: String = "", color: Color = .pink, alignment: HorizontalAlignment = .leading, spacing: CGFloat = 4) -> some View {
        self.modifier(BottomTextStyle(text, color: color, alignment: alignment, spacing: spacing))
    }
}

struct BottomTextStyleModifier_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("Hello, World!")
                .frame(maxWidth: .infinity, alignment: .leading)
                .bottomText("This is a message.", color: .blue, alignment: .leading, spacing: 10)
                .padding(.horizontal)
            
            Text("Hello, World!")
                .frame(maxWidth: .infinity, alignment: .trailing)
                .bottomText("This is a message.", color: .green, alignment: .center, spacing: 8)
                .padding(.horizontal)

            Text("Hello, World!")
                .frame(maxWidth: .infinity, alignment: .leading)
                .bottomText("This is a message.", color: .pink, alignment: .trailing, spacing: 6)
                .padding(.horizontal)

            Text("Hello, World!")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .roundedBackgroundStyle(.field)
                .bottomText("This is a message.")
                .padding(.horizontal)
        }
    }
}




