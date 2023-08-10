//
//  Paginatable.swift
//  topchurch_ios
//
//  Created by minghui on 2023/3/6.
//

import SwiftUI

public protocol Paginable {
    associatedtype Item
    associatedtype Parameters
    static func fetch(start: Int, limit: Int, parameters: Parameters?) async throws -> [Item]
}

public class PaginatedStore<P: Paginable>: ObservableObject where P.Item: Identifiable {
    public typealias Item = P.Item
    
    @Published public var items: [Item] = []
    @Published public var isLoading = false {
        didSet {
            debugPrint("PaginatedStore isLoading:\(isLoading)")
        }
    }
    @Published public var error: Error?
    @Published public var isNextLoading = false
    @Published public var errorNext: Error?
    @Published public var isEmpty: Bool = false
    private var hasMoreItems: Bool = true
    
    private var parameters: P.Parameters?
    private var currentStart = 0
    private let paginable: P.Type
    private let limit: Int
    
    private var currentTask: Task<Void, Never>?
    
    public init(paginable: P.Type, limit: Int = 20, parameters: P.Parameters? = nil) {
        self.paginable = paginable
        self.limit = limit
        self.parameters = parameters
        
        debugPrint("PaginatedStore fetchData 0")
        fetchData()
    }
    
    public func updateParameters(_ newParameters: P.Parameters) {
        debugPrint("PaginatedStore fetchData 1")
        self.parameters = newParameters
        self.currentStart = 0
        self.items = []
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
                
                guard hasMoreItems else {
                    print("request next no more items.")
                    return
                }
            }
            
            DispatchQueue.main.async {
                if isNext {
                    self.errorNext = nil
                    self.isNextLoading = true
                } else {
                    debugPrint("PaginatedStore fetchData 2")
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
                        debugPrint("PaginatedStore fetchData 3")
                        self.isLoading = false
                    }
                }
            }
            
            do {
                let newItems = try await paginable.fetch(start: currentStart, limit: limit, parameters: self.parameters)
                DispatchQueue.main.async {
                    if isNext {
                        self.items.append(contentsOf: newItems)
                    } else {
                        self.items = newItems
                        self.isEmpty = self.items.isEmpty
                    }
                    self.currentStart += newItems.count
                    self.hasMoreItems = newItems.count == self.limit
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
