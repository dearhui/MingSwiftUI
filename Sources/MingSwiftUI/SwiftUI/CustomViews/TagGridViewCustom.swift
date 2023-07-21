//
//  TagGridView.swift
//  eco2
//
//  Created by minghui on 2023/7/12.
//

import SwiftUI

public struct TagGridViewCustom<Content: View, Item: Hashable & CustomStringConvertible>: View {
    public var tags: [Item]
    public var content: (Item) -> Content
    @State private var totalHeight = CGFloat.zero
    
    public init(tags: [Item], @ViewBuilder content: @escaping (Item) -> Content) {
        self.tags = tags
        self.content = content
    }

    public var body: some View {
        VStack {
            GeometryReader { geometry in
                self.createZStack(in: geometry)
            }
        }
        .frame(height: totalHeight)
    }

    private func createZStack(in g: GeometryProxy) -> some View {
        var width: CGFloat = 0
        var height: CGFloat = 0

        return ZStack(alignment: .topLeading) {
            ForEach(self.tags, id: \.self) { tag in
                self.content(tag)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if tag == self.tags.last! {
                            width = 0
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { d in
                        let result = height
                        if tag == self.tags.last! {
                            height = 0
                        }
                        return result
                    })
            }
        }
        .background(viewHeightReader($totalHeight))
    }

    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}

struct TagGridView_Previews: PreviewProvider {
    static var previews: some View {
        TagGridViewCustom(tags: ["Hello", "World", "test", "demo", "macbook pro", "apple air pods", "rock", "a"]) { text in
            Text(text)
                .padding(.vertical, 2)
                .padding(.horizontal, 12)
                .capsuleStyle()
        }
    }
}
