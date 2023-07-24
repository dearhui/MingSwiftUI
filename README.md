# MingSwiftUI

## Usage Instructions for PaginatedStore and PaginatedList

This library provides two main classes: `PaginatedStore` and `PaginatedList` which use SwiftUI and Swift 5.5's async/await features to facilitate paginated data loading.

### Paginable Protocol

Any data model that wishes to use the `PaginatedStore` must implement the `Paginable` protocol. This protocol includes a static `fetch` method, which takes two parameters, `start` and `limit`, and returns an array of `Item`.

Here's an example:

```swift
struct Post: Identifiable {
    let id: Int
    let title: String
}

extension Post: Paginable {
    static func fetch(start: Int, limit: Int) async throws -> [Post] {
        // Omitted actual loading logic
    }
}
```

### PaginatedStore

`PaginatedStore` is a storage model for managing `Paginable` objects.

#### Initializing PaginatedStore

You can initialize a `PaginatedStore` by specifying a type that implements `Paginable`. You can choose to set a `limit` parameter or use the default value of 20.

```swift
let store = PaginatedStore(paginable: Post.self, limit: 20)
```

Upon initialization, `PaginatedStore` will automatically load the first page of data.

#### Loading More Data

If you wish to load more data, simply call the `fetchData` method and set `isNext` to `true`.

```swift
store.fetchData(isNext: true)
```

#### Canceling Tasks

If you need to cancel an ongoing loading task, simply call the `cancelTask` method.

```swift
store.cancelTask()
```

#### Status and Error Handling

You can observe the following properties to get loading status and error messages:

- `isLoading`: Indicates whether the first page of data is being loaded.
- `isNextLoading`: Indicates whether the next page of data is being loaded.
- `error`: Error message when loading the first page of data.
- `errorNext`: Error message when loading the next page of data.

### PaginatedList

`PaginatedList` is a `View` that creates a paginated list using a `PaginatedStore`.

#### Using PaginatedList

You can initialize a `PaginatedList` by providing a `PaginatedStore` instance and a view builder to generate the content of the list. When the user scrolls to the last item in the list, `PaginatedList` automatically loads the next page of data.

Here's an example of using `PaginatedList`:

```swift
struct ContentView: View {
    @ObservedObject var store = PaginatedStore(paginable: Post.self)

    var body: some View {
        PaginatedList(paginatedStore: store) { post in
            Text(post.title)
        }
    }
}
```

The above covers the basic usage of `PaginatedStore` and `PaginatedList`.

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
