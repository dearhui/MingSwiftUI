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
    
    func fetch() async {
        DispatchQueue.main.async {
            self.currentPage = 1
            self.errorNext = nil
            self.isLoading = true
        }
        
        defer {
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
        do {
            let items = try await paginable.fetch(page: currentPage, limit: limit)
            DispatchQueue.main.async {
                self.items = items
            }
        } catch {
            DispatchQueue.main.async {
                self.error = error
            }
        }
    }
    
    func fetchNext() async {
        guard errorNext == nil else {
            print("request next (\(currentPage)) error: \(errorNext?.localizedDescription ?? "")")
            return
        }
            
        DispatchQueue.main.async {
            self.currentPage += 1
            self.errorNext = nil
            self.isNextLoading = true
        }
        
        defer {
            DispatchQueue.main.async {
                self.isNextLoading = false
            }
        }
        do {
            let items = try await paginable.fetch(page: currentPage, limit: limit)
            
            DispatchQueue.main.async {
                self.items.append(contentsOf: items)
            }
        } catch {
            DispatchQueue.main.async {
                self.errorNext = error
            }
        }
    }
    
    func update(newItem: Item) {
        if let index = items.firstIndex(where: { $0.id == newItem.id }) {
            DispatchQueue.main.async {
                self.items[index] = newItem
            }
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

