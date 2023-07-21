//
//  SwiftUIView.swift
//  
//
//  Created by minghui on 2022/7/9.
//

import SwiftUI

public struct EmbedInStack: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    
    @State var category: ContentSizeCategory

    public func body(content: Content) -> some View {
        Group {
            if sizeCategory > category {
                VStack { content }
            } else {
                HStack { content }
            }
        }
    }
}

extension Group where Content: View {
    public func embedInStack(category: ContentSizeCategory) -> some View {
        modifier(EmbedInStack(category: category))
    }
}
