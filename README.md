# MingSwiftUI

## WebSocketService 套件使用指南

這個套件提供了一個方便的方法來與 WebSocket 伺服器進行連接和通信。

### 初始化連接

首先，建立一個 `WebSocketService` 實例並連接到 WebSocket 伺服器。

```swift
let token = "YourAuthorizationToken"
let url = URL(string: "wss://your-websocket-server.com")!
let webSocketService = WebSocketService(url: url, token: token)
webSocketService.connect()
```

`WebSocketService` 构造器需要两个参数：连接的 URL 和 token。这个 token 将用于 "Bearer" 验证。

### 發送和接收訊息

使用 `sendMessage` 方法來發送訊息：

```swift
webSocketService.sendMessage("YourMessage")
```

訂閱 `messageReceived` 來接收來自伺服器的訊息：

```swift
webSocketService.$messageReceived.sink { text in
    print("Received message: \(text)")
}
```

### 監控連接狀態

使用 `connectionStatus` 属性可以監控 WebSocket 連接的狀態。這是一個 `ConnectionStatus` 枚舉值，可能為 `connected`、`disconnected` 或 `error`。

```swift
webSocketService.$connectionStatus.sink { status in
    switch status {
    case .connected:
        print("Connected")
    case .disconnected:
        print("Disconnected")
    case .error(let error):
        print("Error: \(error)")
    }
}
```

### 斷開連接

當你不再需要與 WebSocket 伺服器進行通信時，可以調用 `disconnect` 方法來斷開連接：

```swift
webSocketService.disconnect()
```
