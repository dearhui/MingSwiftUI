//
//  Paginatable.swift
//  topchurch_ios
//
//  Created by minghui on 2023/3/6.
//

import SwiftUI

protocol Paginable {
    associatedtype Item
    static func fetch(start: Int, limit: Int) async throws -> [Item] // 修改 fetch 函數參數
}

class PaginatedStore<P: Paginable>: ObservableObject where P.Item: Identifiable {
    typealias Item = P.Item
    
    @Published var items: [Item] = []
    @Published var isLoading = false
    @Published var error: Error?
    @Published var isNextLoading = false
    @Published var errorNext: Error?
    
    private var currentStart = 0
    private let paginable: P.Type
    private let limit: Int
    
    private var currentTask: Task<Void, Never>? // 管理當前任務的實例變數
    
    init(paginable: P.Type, limit: Int = 20) {
        self.paginable = paginable
        self.limit = limit
        
        fetchData()
    }
    
    func fetchData(isNext: Bool = false) {
        cancelTask() // 在開始新任務前取消當前任務
        
        currentTask = Task {
            if isNext {
                guard errorNext == nil else {
                    print("request next (\(currentStart)) error: \(errorNext?.localizedDescription ?? "")")
                    return
                }
            }
            
            DispatchQueue.main.async {
                if isNext {
                    self.errorNext = nil
                    self.isNextLoading = true
                } else {
                    self.currentStart = 0
                    self.error = nil
                    self.isLoading = true
                }
            }
            
            defer {
                DispatchQueue.main.async {
                    if isNext {
                        self.isNextLoading = false
                    } else {
                        self.isLoading = false
                    }
                }
            }
            
            do {
                let newItems = try await paginable.fetch(start: currentStart, limit: limit)
                DispatchQueue.main.async {
                    if isNext {
                        self.items.append(contentsOf: newItems)
                    } else {
                        self.items = newItems
                    }
                    self.currentStart += newItems.count
                }
            } catch {
                DispatchQueue.main.async {
                    if isNext {
                        self.errorNext = error
                    } else {
                        self.error = error
                    }
                }
            }
        }
    }
    
    func cancelTask() {
        currentTask?.cancel() // 取消當前任務
        currentTask = nil
    }
}
