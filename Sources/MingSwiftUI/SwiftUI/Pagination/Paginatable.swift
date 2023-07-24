//
//  Paginatable.swift
//  topchurch_ios
//
//  Created by minghui on 2023/3/6.
//

import SwiftUI

public protocol Paginable {
    associatedtype Item
    static func fetch(start: Int, limit: Int) async throws -> [Item]
}

public class PaginatedStore<P: Paginable>: ObservableObject where P.Item: Identifiable {
    public typealias Item = P.Item
    
    @Published public var items: [Item] = []
    @Published public var isLoading = false
    @Published public var error: Error?
    @Published public var isNextLoading = false
    @Published public var errorNext: Error?
    
    private var currentStart = 0
    private let paginable: P.Type
    private let limit: Int
    
    private var currentTask: Task<Void, Never>?
    
    public init(paginable: P.Type, limit: Int = 20) {
        self.paginable = paginable
        self.limit = limit
        
        fetchData()
    }
    
    public func fetchData(isNext: Bool = false) {
        cancelTask()
        
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
    
    public func cancelTask() {
        currentTask?.cancel()
        currentTask = nil
    }
}
