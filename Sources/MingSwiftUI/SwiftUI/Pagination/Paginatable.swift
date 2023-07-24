//
//  Paginatable.swift
//  topchurch_ios
//
//  Created by minghui on 2023/3/6.
//

import SwiftUI

protocol Paginable {
    associatedtype Item
    static func fetch(page: Int, limit: Int) async throws -> [Item]
    static var emptyMessage: String { get }
}

class PaginatedStore<P: Paginable>: ObservableObject where P.Item: Identifiable {
    typealias Item = P.Item
    
    @Published var items: [Item] = []
    @Published var isLoading = false
    @Published var error: Error?
    @Published var isNextLoading = false
    @Published var errorNext: Error?
    
    private var currentPage = 1
    private let paginable: P.Type
    private let limit: Int
    
    init(paginable: P.Type, limit: Int = 20) {
        self.paginable = paginable
        self.limit = limit
        
        Task {
            await fetch()
        }
    }
    
    @MainActor
    func fetch() async {
        currentPage = 1
        errorNext = nil
        isLoading = true
        
        defer {
            self.isLoading = false
        }
        do {
            let items = try await paginable.fetch(page: currentPage, limit: limit)
            self.items = items
        } catch {
            self.error = error
        }
    }
    
    @MainActor
    func fetchNext() async {
        guard errorNext == nil else {
            print("request next (\(currentPage)) error: \(errorNext?.localizedDescription ?? "")")
            return
        }
        
        currentPage += 1
        errorNext = nil
        isNextLoading = true
        
        defer {
            self.isNextLoading = false
        }
        do {
            let items = try await paginable.fetch(page: currentPage, limit: limit)
            self.items.append(contentsOf: items)
        } catch {
            self.errorNext = error
        }
    }
    
    @MainActor
    func update(newItem: Item) {
        if let index = items.firstIndex(where: { $0.id == newItem.id }) {
            items[index] = newItem
        }
    }
}
/*
 struct RESTPrayForMe: Codable, Paginable {
     typealias Item = RESTPrayForMe
     let title: String
     let content: String
     // ...
     
     static func fetch(page: Int, limit: Int) async throws -> [RESTPrayForMe] {
         // 實作 REST API 的呼叫，並且回傳取得的項目
     }
 }

 let viewModel = PaginatedListViewModel(paginable: RESTPrayForMe.self)

 // 讀取第一頁
 await viewModel.fetch()

 // 讀取下一頁
 await viewModel.fetch(isNext: true)

 */

