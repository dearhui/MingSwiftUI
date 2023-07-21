//
//  MaterialDesignTextField.swift
//  TopChurch (iOS)
//
//  Created by minghui on 2022/9/21.
//

import SwiftUI
import PureSwiftUI

public struct MaterialDesignTextField: View {
    @Environment(\.isEnabled) private var isEnabled
    
    private let name: LocalizedStringKey
    private let hint: LocalizedStringKey?
    @Binding private var value: String
    private let isSecure: Bool
    private let verified: Bool
    private let focused: Bool
    
    @State private var mySecure: Bool
    
    public init(name: LocalizedStringKey,
                value: Binding<String>,
                isSecure: Bool = false,
                hint: LocalizedStringKey? = nil,
                verified: Bool = true,
                focused: Bool = false) {
        self.name = name
        self.hint = hint
        self._value = value
        self.isSecure = isSecure
        self.verified = verified
        self.focused = focused
        self._mySecure = State(wrappedValue: isSecure)
    }
    
    private var _verified: Bool {
        if focused || value.isEmpty { return true }
        return verified
    }
    
    private var isMini: Bool {
        return focused || !value.isEmpty
    }
    
    public var body: some View {
        VStack (spacing: 4) {
            textField
            hintView
        }
        .animation(.easeInOut, value: isMini)
    }
    
    private var textField: some View {
        ZStack {
            inputField
            label
        }
        .padding()
        .background(fieldBackground)
        .overlayIf(isSecure, eyeButton, alignment: .trailing)
    }
    
    @ViewBuilder
    private var inputField: some View {
        Group {
            if isSecure && mySecure {
                SecureField("", text: $value)
            } else {
                TextField("", text: $value)
            }
        }
        .autocorrectionDisabled(true)
        .autocapitalization(.none)
        .yOffsetIf(isMini, 8)
        .foregroundColor(isEnabled ? Color(UIColor.label) : Color(UIColor.secondaryLabel))
    }
    
    private var label: some View {
        Text(name)
            .greedyWidth(.leading)
            .font(isMini ? .caption : .body)
            .yOffsetIf(isMini, -12)
            .foregroundColor(isMini ? .accentColor : Color(UIColor.placeholderText))
            .zIndex(-1)
    }
    
    private var fieldBackground: some View {
        RoundedRectangle(cornerRadius: 8)
            .strokeBorder(_verified ? Color.clear : Color(UIColor.systemPink))
            .background(
                Color(UIColor.tertiarySystemBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            )
    }
    
    @ViewBuilder
    private var hintView: some View {
        if let hint = hint {
            Text(hint)
                .font(.caption)
                .greedyWidth(.leading)
                .padding(.horizontal)
                .foregroundColor(_verified ? Color(UIColor.secondaryLabel) : Color(UIColor.systemPink))
                .opacity( (focused || !_verified) ? 1 : 0)
        }
    }
    
    private var eyeButton: some View {
        Button {
            mySecure.toggle()
        } label: {
            Image(sfSymbol: mySecure ? .eye_slash_fill : .eye_fill)
                .padding()
                .foregroundColor(.secondary)
        }
        .zIndex(100)
    }
}


struct MaterialDesignTextField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MaterialDesignTextField(name: "register_nick_name",
                                     value: .constant(""),
                                     hint: "register_nick_name_hint",
                                     verified: true,
                                     focused: false)
            MaterialDesignTextField(name: "register_nick_name",
                                     value: .constant("disabled true"),
                                     hint: "register_nick_name_hint",
                                     verified: true,
                                     focused: false)
            .disabled(true)
            MaterialDesignTextField(name: "register_nick_name",
                                     value: .constant("123"),
                                     hint: "register_nick_name_hint",
                                     verified: true,
                                     focused: true)
            MaterialDesignTextField(name: "register_nick_name",
                                     value: .constant("123"),
                                     hint: "register_nick_name_hint",
                                     verified: false,
                                     focused: false)
            MaterialDesignTextField(name: "密碼",
                                     value: .constant("123"), isSecure: true,
                                     hint: "register_nick_name_hint",
                                     verified: false,
                                     focused: false)
        }
        .padding()
//        .backgroundColor(.secondarySystemBackground)
    }
}
