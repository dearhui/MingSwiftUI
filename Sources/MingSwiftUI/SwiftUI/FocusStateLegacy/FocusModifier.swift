//
//  FocusModifier.swift
//  
//
//  Created by Augustinas Malinauskas on 01/09/2021.
//

import SwiftUI
import SwiftUIIntrospect

public struct FocusModifier<Value: Hashable>: ViewModifier {
    @Binding var focusedField: Value?
    var equals: Value
    @State var observer = TextFieldObserver()
    
    public func body(content: Content) -> some View {
        content
            .introspect(.textField, on: .iOS(.v13, .v14, .v15, .v16, .v17)) { textField in
                if !(textField.delegate is TextFieldObserver) {
                    observer.forwardToDelegate = textField.delegate
                    textField.delegate = observer
                }
                
                observer.onEditingBegin = {
                    focusedField = equals
                }
                
                observer.onEditingEnd = {
                    focusedField = nil
                }
                
                observer.onReturnTap = {
                    focusedField = nil
                }
                
                if focusedField == equals {
                    textField.becomeFirstResponder()
                }
            }
            .simultaneousGesture(TapGesture().onEnded {
                focusedField = equals
            })
            .onChange(of: focusedField) { newValue in
                if newValue == nil {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
            }
    }
}

public extension View {
    func focusedLegacy<T: Hashable>(_ focusedField: Binding<T?>, equals: T) -> some View {
        modifier(FocusModifier(focusedField: focusedField, equals: equals))
    }
}
