//
//  KeyboardExtensions.swift
//  TopChurch (iOS)
//
//  Created by minghui on 2022/9/22.
//

import SwiftUI
import UIKit

extension View {
    public func onTapKeyboardHidden() -> some View {
        self
            .contentShape(Rectangle())
            .onTapGesture {
                hideKeyboard()
            }
    }
}

#if canImport(UIKit)
extension View {
    public func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
