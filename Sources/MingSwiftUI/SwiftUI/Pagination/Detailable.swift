//
//  DetailStore.swift
//  topchurch_ios
//
//  Created by minghui on 2023/3/15.
//

import SwiftUI

public protocol Detailable {
    associatedtype Item
    func fetch() async throws -> Item
}

public class DetailStore<T: Detailable>: ObservableObject {
    public var item: T {
        didSet {
            fetch()
        }
    }
    
    @Published public var detail: T.Item?
    @Published public var isLoading = false
    @Published public var error: Error?
    
    public init(item: T) {
        self.item = item
        fetch()
    }
    
    public func fetch() {
        Task {
            defer {
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
            
            do {
                DispatchQueue.main.async {
                    self.detail = nil
                    self.error = nil
                    self.isLoading = true
                }
                
                let detail = try await item.fetch()
                
                DispatchQueue.main.async {
                    self.detail = detail
                }
            } catch {
                DispatchQueue.main.async {
                    self.error = error
                }
            }
        }
    }
}


