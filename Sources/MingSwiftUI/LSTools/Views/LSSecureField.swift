//
//  LSSecureField.swift
//  ECO2
//
//  Created by minghui on 2021/7/26.
//

import SwiftUI

public struct LSSecureField: View {
    
    public init(title: String = "",
                titleWidth: CGFloat = 0,
                placeholder: String,
                text: Binding<String>,
                boderColor: Color? = nil,
                verified: Bool = true
    ) {
        self.title = title
        self.titleWidth = titleWidth
        self.placeholder = placeholder
        self.boderColor = boderColor
        self.verified = verified
        self._text = text
    }
    
    
    var title: String = ""
    var titleWidth: CGFloat = 0
    var placeholder: String
    @Binding var text: String
    var boderColor: Color? = nil
    var verified: Bool = true
    
    @State private var isSecured: Bool = true
    
    public var body: some View {
        
        HStack {
            
            if titleWidth > 0 {
                Text(title)
                    .font(.system(size: 16))
                    .foregroundColor(.gray800)
                    .frame(width: titleWidth, alignment: .leading)
            }
            
            Group {
                if isSecured {
                    SecureField(placeholder, text: $text)
                } else {
                    TextField(placeholder, text: $text)
                }
            }
            .font(.system(size: 16))
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .minimumScaleFactor(0.5)
            
            Button(action: {
                isSecured.toggle()
            }, label: {
                Image(systemName: isSecured ? "eye.slash.fill" : "eye.fill")
                    .font(.system(size: 18))
                    .foregroundColor(.gray500)
            })
        }
        .padding()
        .frame(height: 44)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(strokeBoderColor)
        )
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.grayF2)
        )
    }
    
    var strokeBoderColor: Color {
        if let color = boderColor {
            return color
        } else {
            return verifiedSpace ? .clear : .redWrong
        }
    }
    
    var verifiedSpace: Bool {
        return (text == "") ? true : verified
    }
}

struct LSSecureField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            LSSecureField(placeholder: "密碼", text: .constant(""))
            LSSecureField(placeholder: "密碼", text: .constant(""), boderColor: .red)
            LSSecureField(placeholder: "密碼", text: .constant(""), verified: false)
            LSSecureField(placeholder: "密碼", text: .constant("123"), verified: false)
            LSSecureField(placeholder: "密碼", text: .constant("123"), verified: true)
            LSSecureField(title:"123", titleWidth: 60 ,placeholder: "密碼", text: .constant(""), verified: true)
        }
        .padding()
    }
}
