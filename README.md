# MingSwiftUI

## WebSocketService 套件使用指南

首先，我們先創建一個 `WebSocketService` 的實例並將它設為 `@EnvironmentObject`。這樣我們就可以在我們的 view hierarchy 中的任何地方使用它了。

```swift
@main
struct YourApp: App {
    @StateObject var webSocketService = WebSocketService(url: URL(string: "wss://your-websocket-server.com")!, token: "YourAuthorizationToken")

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(webSocketService)
        }
    }
}
```

在你的 view 中，你可以透過 `@EnvironmentObject` 屬性來存取 `WebSocketService`：

```swift
struct ContentView: View {
    @EnvironmentObject var webSocketService: WebSocketService

    var body: some View {
        VStack {
            Text("Received message: \(webSocketService.messageReceived)")
            Text("Connection status: \(webSocketService.connectionStatus)")

            Button(action: {
                webSocketService.sendMessage("Hello, world!")
            }) {
                Text("Send Message")
            }
        }
        .onAppear {
            webSocketService.connect()
        }
        .onDisappear {
            webSocketService.disconnect()
        }
    }
}
```
