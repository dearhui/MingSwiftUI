//
//  TagGridPicker.swift
//  eco2
//
//  Created by minghui on 2023/7/12.
//

import SwiftUI

public struct LeadingGridPickerCustom<Item: Hashable & CustomStringConvertible, Content: View>: View {
    public var items: [Item]
    @Binding public var selection: Item
    public var content: (Item, Bool) -> Content
    
    public init(items: [Item], selection: Binding<Item>, @ViewBuilder content: @escaping (Item, Bool) -> Content) {
        self.items = items
        self._selection = selection
        self.content = content
    }

    public var body: some View {
        LeadingGridCustom(tags: items) { item in
            Button {
                self.selection = item
            } label: {
                content(item, item == selection)
            }
        }
    }
}

struct TagGridPickerView_Previews: PreviewProvider {
    enum Options: String, CaseIterable, Hashable, CustomStringConvertible {
            case firstOption = "First"
            case secondOption = "Second"
            case thirdOption = "Third"

            var description: String { self.rawValue }
        }

    @State private static var selection: Options = .secondOption

    static var previews: some View {
        LeadingGridPickerCustom(items: Options.allCases, selection: $selection) { (item, selected)  in
            if selected {
                Text(item.description)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
                    .capsuleStyle()
            } else {
                Text(item.description)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
                    .capsuleStyle(textColor: .black, backgroundColor: .white, strokeColor: .gray)
            }
        }
    }
}
