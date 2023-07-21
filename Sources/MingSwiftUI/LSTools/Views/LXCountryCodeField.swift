//
//  LXCountryCodeField.swift
//  TopChurch (iOS)
//
//  Created by minghui on 2022/9/22.
//

import SwiftUI
import PureSwiftUI

public struct LXCountryCodeField: View {
    @Binding var code: String
    
    public init(code: Binding<String>) {
        self._code = code
    }
    
    public var body: some View {
        HStack {
            Text(code)
                .font(.body)
                .foregroundColor(.gray500)
            Image(systemName: "arrowtriangle.down.fill")
                .resizable()
                .foregroundColor(.gray500)
                .frame(width: 10, height: 6)
        }
        .padding()
        .backgroundColor(Color(UIColor.secondarySystemBackground))
        .clipRoundedRectangle(8)
//        .modifier(LSfieldBackgroundModifier())
    }
}

struct LXCountryCodeField_Previews: PreviewProvider {
    static var previews: some View {
        LXCountryCodeField(code: .constant("+886"))
    }
}
