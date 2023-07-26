//
//  SwiftUIView.swift
//  
//
//  Created by minghui on 2023/7/25.
//

import SwiftUI

@available(iOS 15, *)
public struct FocusStateModifier<Value: Hashable>: ViewModifier where Value: Hashable {
    @Binding public var focusState: Value?
    public var equals: Value

    @FocusState private var internalFocusState: Value?

    public func body(content: Content) -> some View {
        content
            .focused($internalFocusState, equals: equals)
            .onChange(of: focusState) { newValue in
                internalFocusState = newValue
            }
            .onChange(of: internalFocusState) { newValue in
                focusState = newValue
            }
    }
}

public struct FocusStateLegacyModifier<Value: Hashable>: ViewModifier where Value: Hashable {
    @Binding public var focusState: Value?
    public var equals: Value

    public func body(content: Content) -> some View {
        content
            .focusedLegacy($focusState, equals: equals)
    }
}

public extension View {
    @ViewBuilder
    func universalFocused<Value: Hashable>(_ focus: Binding<Value?>, equals value: Value) -> some View {
        if #available(iOS 15, *) {
            self.modifier(FocusStateModifier(focusState: focus, equals: value))
        } else {
            self.modifier(FocusStateLegacyModifier(focusState: focus, equals: value))
        }
    }
}
