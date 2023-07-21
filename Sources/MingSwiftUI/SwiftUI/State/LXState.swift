//
//  LXState.swift
//  
//
//  Created by minghui on 2022/7/9.
//

import SwiftUI

public enum LXState<T> {
    case initial
    case loading
    case finish(data: T)
    case error(error: Error)
    case empty
    
    public var isFinish: T? {
        if case let .finish(d) = self {
            return d
        }
        return nil
    }
    
    public var isEmpty: Bool {
        if case .empty = self {
            return true
        }
        return false
    }
    
    public var isLoading: Bool {
        if case .loading = self {
            return true
        }
        return false
    }
    
    public var isError: Error? {
        if case let .error(e) = self {
            return e
        }
        return nil
    }
    
    public var isInitial: Bool {
        if case .initial = self {
            return true
        }
        return false
    }
}
