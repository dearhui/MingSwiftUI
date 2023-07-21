//
//  File.swift
//  
//
//  Created by minghui on 2023/7/21.
//

import SwiftUI

public struct RoundedBackgroundStyleModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme

    public func body(content: Content) -> some View {
        content
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .foregroundColor(colorScheme == .dark ? Color(UIColor.secondarySystemBackground) : Color(UIColor.systemBackground))
                    .shadow(color: .black.opacity(0.25), radius: 3, x: 1, y: 2)
            )
    }
}

public extension View {
    func roundedBackgroundStyle() -> some View {
        self.modifier(RoundedBackgroundStyleModifier())
    }
}

struct RoundedBackgroundStyleModifier_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, World!")
            .roundedBackgroundStyle()
            .padding()
    }
}


