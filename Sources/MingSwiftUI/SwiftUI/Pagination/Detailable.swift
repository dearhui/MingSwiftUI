//
//  DetailStore.swift
//  topchurch_ios
//
//  Created by minghui on 2023/3/15.
//

import SwiftUI

protocol Detailable {
    associatedtype Item
    func fetch() async throws -> Item
}

class DetailStore<T: Detailable>: ObservableObject {
    var item: T {
        didSet {
            fetch()
        }
    }
    
    @Published var detail: T.Item?
    @Published var isLoading = false
    @Published var error: Error?
    
    init(item: T) {
        self.item = item
        fetch()
    }
    
    func fetch() {
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

