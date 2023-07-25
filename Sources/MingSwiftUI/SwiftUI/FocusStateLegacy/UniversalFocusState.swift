//
//  SwiftUIView.swift
//  
//
//  Created by minghui on 2023/7/25.
//

import SwiftUI

@available(iOS 15, *)
struct FocusStateModifier<Value: Hashable>: ViewModifier where Value: Hashable {
    @Binding var focusState: Value?
    var equals: Value

    @FocusState private var internalFocusState: Value?

    func body(content: Content) -> some View {
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

struct FocusStateLegacyModifier<Value: Hashable>: ViewModifier where Value: Hashable {
    @Binding var focusState: Value?
    var equals: Value

    func body(content: Content) -> some View {
        content
            .focusedLegacy($focusState, equals: equals)
    }
}

extension View {
    @ViewBuilder
    func universalFocused<Value: Hashable>(_ focus: Binding<Value?>, equals value: Value) -> some View {
        if #available(iOS 15, *) {
            self.modifier(FocusStateModifier(focusState: focus, equals: value))
        } else {
            self.modifier(FocusStateLegacyModifier(focusState: focus, equals: value))
        }
    }
}

enum Field: Hashable {
    case username
    case password
}

struct FocusedDemoView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var focusedField: Field?

    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .universalFocused($focusedField, equals: .username)
            
            SecureField("Password", text: $password)
                .universalFocused($focusedField, equals: .password)
            
            Button("to Username") {
                print("Username button tapped")
                focusedField = .username
            }
            
            Button("to password") {
                print("password button tapped")
                focusedField = .password
            }
            
            Button("Dismiss") {
                print("Dismiss button tapped")
                focusedField = nil
            }
        }
        .padding()
    }
}

struct FocusedDemoView_Previews: PreviewProvider {
    static var previews: some View {
        FocusedDemoView()
    }
}
