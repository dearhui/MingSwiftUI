//
//  File.swift
//  
//
//  Created by minghui on 2023/6/9.
//

import SwiftUI

public enum ConnectionStatus {
    case connected
    case disconnected
    case error(String)
}

public class WebSocketService: ObservableObject {
    @Published public var messageReceived = ""
    @Published public var connectionStatus: ConnectionStatus = .disconnected
    
    var urlSession: URLSession
    var webSocketTask: URLSessionWebSocketTask?
    
    public init(url: URL, token: String) {
        self.urlSession = URLSession(configuration: .default)
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        self.webSocketTask = urlSession.webSocketTask(with: request)
    }
    
    public func connect() {
        self.webSocketTask?.resume()
        self.connectionStatus = .connected
        
        self.receiveMessage()
        self.ping()
    }
    
    public func disconnect() {
        self.webSocketTask?.cancel(with: .goingAway, reason: nil)
        self.connectionStatus = .disconnected
    }
    
    private func receiveMessage() {
        self.webSocketTask?.receive(completionHandler: { result in
            switch result {
            case .failure(let error):
                print("WebSocket接收失敗: \(error)")
                self.connectionStatus = .error(error.localizedDescription)
            case .success(let message):
                switch message {
                case .string(let text):
                    DispatchQueue.main.async {
                        self.messageReceived = text
                    }
                case .data(let data):
                    print("Received data: \(data)")
                @unknown default:
                    print("Unknown data")
                }
                
                self.receiveMessage()
            }
        })
    }
    
    public func sendMessage(_ message: String) {
        self.webSocketTask?.send(.string(message), completionHandler: { error in
            if let error = error {
                print("WebSocket發送失敗: \(error)")
                self.connectionStatus = .error(error.localizedDescription)
            }
        })
    }
    
    private func ping() {
        self.webSocketTask?.sendPing { error in
            if let error = error {
                print("WebSocket發送Ping失敗: \(error)")
                self.connectionStatus = .error(error.localizedDescription)
            } else {
                DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(10)) {
                    self.ping()
                }
            }
        }
    }
}

