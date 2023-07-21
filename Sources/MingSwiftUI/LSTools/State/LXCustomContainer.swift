//
//  SwiftUIView.swift
//  
//
//  Created by minghui on 2022/7/9.
//

import SwiftUI

public struct LXCustomContainer<T, Content: View, InitContent: View, ErrContent: View, EmptyContent: View, LoadingContent: View>: View {
    
    var state: LXState<T>
    var content: (T) -> Content
    var initContent: () -> InitContent
    var errContent: (Error) -> ErrContent
    var emptyContent: () -> EmptyContent
    var loadingContent: () -> LoadingContent

    public init(state: LXState<T>,
         content: @escaping (T) -> Content,
         initContent: @escaping () -> InitContent,
         errContent: @escaping (Error) -> ErrContent,
         emptyContent: @escaping () -> EmptyContent,
         loadingContent: @escaping () -> LoadingContent) {
        self.state = state
        self.content = content
        self.initContent = initContent
        self.errContent = errContent
        self.emptyContent = emptyContent
        self.loadingContent = loadingContent
    }

    public var body: some View {
        VStack {
            switch state {
            case .initial:
                initContent()
            case .loading:
                loadingContent()
            case .error(let err):
                errContent(err)
            case .finish(let data):
                content(data)
            case .empty:
                emptyContent()
            }
        }
    }
}
