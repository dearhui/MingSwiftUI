//
//  PaginatedList.swift
//  topchurch_ios
//
//  Created by minghui on 2023/3/7.
//

import SwiftUI

public struct PaginatedList<Content: View, P: Paginable>: View where P.Item: Identifiable {

    @ObservedObject public var paginatedStore: PaginatedStore<P>
    
    public var spacing: CGFloat = 0
    public let content: (P.Item) -> Content

    public init(paginatedStore: PaginatedStore<P>, spacing: CGFloat = 0, @ViewBuilder content: @escaping (P.Item) -> Content) {
        self.paginatedStore = paginatedStore
        self.spacing = spacing
        self.content = content
    }

    public var body: some View {
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

