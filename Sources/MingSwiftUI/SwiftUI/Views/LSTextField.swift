//
//  LSTextField.swift
//  ECO2
//
//  Created by minghui on 2021/7/26.
//

import SwiftUI

public struct LSTextField: View {
        
    @Binding public  var text: String
    public var placeholder: String
    public var isRedBorder: Bool
    public var title: String
    public var width: CGFloat
    public var isArrow: Bool
    public var arrowColor: Color
    
    public init(placeholder: String, text: Binding<String> ,isRedBorder: Bool = false, title: String = "", width: CGFloat = 0, isArrow: Bool = false, arrowColor: Color = .black) {
        self.placeholder = placeholder
        self._text = text
        self.isRedBorder = isRedBorder
        self.title = title
        self.width = width
        self.isArrow = isArrow
        self.arrowColor = arrowColor
    }
    
    public var body: some View {
        HStack {
            if title != "" {
                Text(title)
                    .font(.system(size: 16))
                    .foregroundColor(.gray800)
                    .frame(width: width, alignment: .leading)
            }
            
            TextField(placeholder, text: $text)
                .font(.system(size: 16))
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
            if isArrow {
                Image(systemName: "arrowtriangle.down.fill")
                    .resizable()
                    .frame(width: 10, height: 6)
                    .foregroundColor(arrowColor)
            }
        }
        .padding()
        .frame(height: 44)
        .modifier(LSfieldBackgroundModifier(verified: !isRedBorder))
    }
}

struct LSTextField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            LSTextField(placeholder: "帳號", text: .constant(""))
            LSTextField(placeholder: "帳號", text: .constant(""), title: "暱稱")
        }
        .padding()
    }
}
