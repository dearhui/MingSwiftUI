//
//  FocusModifier.swift
//  
//
//  Created by Augustinas Malinauskas on 01/09/2021.
//

import SwiftUI
import Introspect

public struct FocusModifier<Value: Hashable>: ViewModifier {
    @Binding var focusedField: Value?
    var equals: Value
    @State var observer = TextFieldObserver()
    
    public func body(content: Content) -> some View {
        content
            .introspectTextField { textField in
                if !(textField.delegate is TextFieldObserver) {
                    observer.forwardToDelegate = textField.delegate
                    textField.delegate = observer
                }
                
                if focusedField == equals {
                    DispatchQueue.main.async {
                        textField.becomeFirstResponder()
                    }
                }
            }
            .simultaneousGesture(TapGesture().onEnded {
                focusedField = equals
            })
    }
}

public extension View {
    func focusedLegacy<T: Hashable>(_ focusedField: Binding<T?>, equals: T) -> some View {
        modifier(FocusModifier(focusedField: focusedField, equals: equals))
    }
}
