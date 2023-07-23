//
//  TrailingArrowStyle.swift
//  
//
//  Created by minghui on 2023/7/21.
//

import SwiftUI

public struct TrailingArrowStyle: ViewModifier {
    var arrowColor: Color
    var spacing: CGFloat
    var size: CGSize

    public init(arrowColor: Color = .primary, spacing: CGFloat = 4, size: CGSize = CGSize(width: 10, height: 6)) {
        self.arrowColor = arrowColor
        self.spacing = spacing
        self.size = size
    }

    public func body(content: Content) -> some View {
        HStack(spacing: spacing) {
            content
            
            Image(systemName: "arrowtriangle.down.fill")
                .resizable()
                .frame(width: size.width, height: size.height)
                .foregroundColor(arrowColor)
        }
    }
}

public extension View {
    func trailingArrowStyle(arrowColor: Color = .primary, spacing: CGFloat = 4, size: CGSize = CGSize(width: 10, height: 6)) -> some View {
        self.modifier(TrailingArrowStyle(arrowColor: arrowColor, spacing: spacing, size: size))
    }
}

struct TrailingArrowStyleModifier_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("Hello, World!")
                .frame(maxWidth: .infinity, alignment: .leading)
                .trailingArrowStyle()
                .padding(.horizontal)
            
            HStack {
                Text("title")
                    .foregroundColor(.primary)
                Spacer()
                Text("description")
                    .foregroundColor(Color.primary)
            }
            .trailingArrowStyle(arrowColor: .red)
            .padding(.horizontal)
            
            Text("886")
                .trailingArrowStyle()
                .padding()
                .roundedBackgroundStyle(.field)
        }
    }
}

