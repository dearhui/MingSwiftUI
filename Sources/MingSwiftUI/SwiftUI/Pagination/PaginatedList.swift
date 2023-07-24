//
//  PaginatedList.swift
//  topchurch_ios
//
//  Created by minghui on 2023/3/7.
//

import SwiftUI

struct PaginatedList<Content: View, P: Paginable>: View where P.Item: Identifiable {

    @ObservedObject var paginatedStore: PaginatedStore<P>
    
    var spacing: CGFloat = 0
    let content: (P.Item) -> Content

    var body: some View {
        LazyVStack (spacing: spacing) {
            ForEach(paginatedStore.items, id: \.id) { item in
                content(item)
                    .onAppear {
                        if paginatedStore.items.isLastItem(item) {
                            paginatedStore.fetchData(isNext: true)
                        }
                    }
            }
        }
    }
}

extension RandomAccessCollection where Self.Element: Identifiable {
    fileprivate func isLastItem<Item: Identifiable>(_ item: Item) -> Bool {
        guard !isEmpty else {
            return false
        }
        
        guard let itemIndex = lastIndex(where: { AnyHashable($0.id) == AnyHashable(item.id) }) else {
            return false
        }
        
        let distance = self.distance(from: itemIndex, to: endIndex)
        return distance == 1
    }
}
