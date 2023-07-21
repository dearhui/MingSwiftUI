//
//  MenuPickerCustom.swift
//  topchurch_ios
//
//  Created by minghui on 2023/7/19.
//

import SwiftUI

public struct MenuPickerCustom<T: Hashable & CustomStringConvertible, Label: View>: View {
    let options: [T]
    @Binding var selection: T
    let label: (T) -> Label

    public init(options: [T], selection: Binding<T>, label: @escaping (T) -> Label) {
        self.options = options
        self._selection = selection
        self.label = label
    }

    public var body: some View {
        Menu {
            Picker("", selection: $selection) {
                ForEach(options, id: \.self) { option in
                    Text(NSLocalizedString(option.description, comment: ""))
                        .tag(option)
                }
            }
        } label: {
            label(selection)
        }
    }
}

struct MenuPickerCustom_Previews: PreviewProvider {    
    static var previews: some View {
        MenuPickerCustom(options: ["Option 1", "Option 2"], selection: .constant("Option 2")) { item in
            Text(item.description)
        }
    }
}
