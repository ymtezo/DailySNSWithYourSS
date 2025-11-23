# Example Usage - DailySNSWithYourSS

このドキュメントでは、DailySNSWithYourSSライブラリの使用方法を説明します。
This document explains how to use the DailySNSWithYourSS library.

## 基本的な使い方 / Basic Usage

### 1. 投稿作成 / Post Creation

```swift
import DailySNSWithYourSS

// ViewModelの作成 / Create ViewModel
let postViewModel = PostCreationViewModel()

// スクリーンショットを追加 / Add screenshot
postViewModel.addScreenshot(imageURL: "https://example.com/screenshot1.jpg")

// コメントを追加（任意） / Add comment (optional)
postViewModel.addComment(text: "今日の作業内容です / Today's work")

// 別のスクリーンショットを追加 / Add another screenshot
postViewModel.addScreenshot(imageURL: "https://example.com/screenshot2.jpg")

// 投稿可能かチェック / Check if can submit
if postViewModel.canSubmit {
    let post = postViewModel.createPost(userId: "currentUser123")
    print("投稿作成完了 / Post created: \(post.id)")
}

// リセット / Reset
postViewModel.reset()
```

### 2. アイテムの削除 / Remove Items

```swift
let postViewModel = PostCreationViewModel()

postViewModel.addScreenshot(imageURL: "screenshot1.jpg")
postViewModel.addComment(text: "コメント / Comment")
postViewModel.addScreenshot(imageURL: "screenshot2.jpg")

// IDで削除 / Remove by ID
if let firstItem = postViewModel.postItems.first {
    postViewModel.removeItem(id: firstItem.id)
}

// インデックスで削除 / Remove by index
postViewModel.removeItem(at: 1)
```

### 3. アルバム閲覧 / Album Viewing

```swift
import DailySNSWithYourSS

// ViewModelの作成 / Create ViewModel
let albumViewModel = AlbumViewModel()

// アルバムを取得 / Fetch albums
albumViewModel.fetchAlbums()

// ローディング状態をチェック / Check loading state
if albumViewModel.isLoading {
    print("読み込み中... / Loading...")
}

// エラーハンドリング / Error handling
if let error = albumViewModel.errorMessage {
    print("エラー / Error: \(error)")
}

// アルバム一覧を表示 / Display albums
for album in albumViewModel.albums {
    print("\(album.userName)のアルバム / Album of \(album.userName)")
    print("投稿数 / Posts: \(album.posts.count)")
}

// アルバムを選択 / Select an album
if let firstAlbum = albumViewModel.albums.first {
    albumViewModel.selectAlbum(firstAlbum)
    
    if let selected = albumViewModel.selectedAlbum {
        print("選択中 / Selected: \(selected.userName)")
    }
}

// 選択解除 / Clear selection
albumViewModel.clearSelection()
```

### 4. ランダムフィード / Random Feed

```swift
import DailySNSWithYourSS

// ViewModelの作成 / Create ViewModel  
let feedViewModel = FeedViewModel(currentUserId: "user123")

// フォロー中のユーザーの投稿を取得 / Fetch posts from following
feedViewModel.fetchPosts()

// 投稿を表示 / Display posts
for post in feedViewModel.posts {
    print("投稿 / Post: \(post.id)")
    print("ユーザー / User: \(post.userId)")
    print("アイテム数 / Items: \(post.activeItems.count)")
}

// グローバルフィードに切り替え / Switch to global feed
feedViewModel.switchFeedType(to: .global)

// 更新 / Refresh
feedViewModel.refresh()
```

## SwiftUIでの使用例 / SwiftUI Example

### 投稿作成画面 / Post Creation View

```swift
import SwiftUI
import DailySNSWithYourSS

struct PostCreationView: View {
    @StateObject private var viewModel = PostCreationViewModel()
    @State private var commentText = ""
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.postItems) { item in
                    HStack {
                        if item.type == .screenshot {
                            Image(systemName: "photo")
                            Text("スクリーンショット / Screenshot")
                        } else {
                            Image(systemName: "text.bubble")
                            Text(item.content)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            viewModel.removeItem(id: item.id)
                        }) {
                            Image(systemName: "xmark.circle")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            
            HStack {
                TextField("コメント / Comment", text: $commentText)
                    .textFieldStyle(.roundedBorder)
                
                Button("追加 / Add") {
                    viewModel.addComment(text: commentText)
                    commentText = ""
                }
            }
            .padding()
            
            Button("投稿 / Post") {
                let post = viewModel.createPost(userId: "user123")
                print("Posted: \(post.id)")
                viewModel.reset()
            }
            .disabled(!viewModel.canSubmit)
            .padding()
        }
    }
}
```

### アルバム一覧画面 / Album List View

```swift
import SwiftUI
import DailySNSWithYourSS

struct AlbumListView: View {
    @StateObject private var viewModel = AlbumViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.albums) { album in
                NavigationLink(destination: AlbumDetailView(album: album)) {
                    VStack(alignment: .leading) {
                        Text(album.userName)
                            .font(.headline)
                        Text("\(album.posts.count) 投稿 / posts")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("アルバム / Albums")
            .onAppear {
                viewModel.fetchAlbums()
            }
        }
    }
}

struct AlbumDetailView: View {
    let album: Album
    
    var body: some View {
        List(album.posts) { post in
            VStack(alignment: .leading) {
                Text("投稿 / Post")
                    .font(.headline)
                Text("\(post.activeItems.count) アイテム / items")
                    .font(.caption)
            }
        }
        .navigationTitle(album.userName)
    }
}
```

### フィード画面 / Feed View

```swift
import SwiftUI
import DailySNSWithYourSS

struct FeedView: View {
    @StateObject private var viewModel: FeedViewModel
    
    init(userId: String) {
        _viewModel = StateObject(wrappedValue: FeedViewModel(currentUserId: userId))
    }
    
    var body: some View {
        VStack {
            Picker("フィード / Feed", selection: $viewModel.feedType) {
                Text("フォロー / Following").tag(FeedViewModel.FeedType.following)
                Text("グローバル / Global").tag(FeedViewModel.FeedType.global)
            }
            .pickerStyle(.segmented)
            .padding()
            .onChange(of: viewModel.feedType) { newType in
                viewModel.switchFeedType(to: newType)
            }
            
            if viewModel.isLoading {
                ProgressView()
            } else if let error = viewModel.errorMessage {
                Text("エラー / Error: \(error)")
                    .foregroundColor(.red)
            } else {
                List(viewModel.posts) { post in
                    PostRowView(post: post)
                }
            }
        }
        .onAppear {
            viewModel.fetchPosts()
        }
        .refreshable {
            viewModel.refresh()
        }
    }
}

struct PostRowView: View {
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(post.activeItems) { item in
                if item.type == .screenshot {
                    // Display screenshot
                    Text("📷 スクリーンショット / Screenshot")
                } else {
                    Text(item.content)
                        .font(.body)
                }
            }
        }
        .padding(.vertical, 4)
    }
}
```

## カスタムデータサービスの実装 / Custom Data Service Implementation

```swift
import Foundation
import DailySNSWithYourSS

class MyCustomDataService: DataServiceProtocol {
    func fetchAlbums() async throws -> [Album] {
        // 実際のAPI呼び出しを実装 / Implement actual API call
        let url = URL(string: "https://api.example.com/albums")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Album].self, from: data)
    }
    
    func fetchRandomFollowingPosts(userId: String) async throws -> [Post] {
        // 実装 / Implementation
        let url = URL(string: "https://api.example.com/posts/following/\(userId)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Post].self, from: data)
    }
    
    func fetchRandomGlobalPosts() async throws -> [Post] {
        // 実装 / Implementation
        let url = URL(string: "https://api.example.com/posts/global")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Post].self, from: data)
    }
    
    func createPost(_ post: Post) async throws -> Post {
        // 実装 / Implementation
        let url = URL(string: "https://api.example.com/posts")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(post)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(Post.self, from: data)
    }
    
    func fetchUser(id: UUID) async throws -> User {
        // 実装 / Implementation
        let url = URL(string: "https://api.example.com/users/\(id)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(User.self, from: data)
    }
}

// カスタムサービスの使用 / Use custom service
let customService = MyCustomDataService()
let albumViewModel = AlbumViewModel(dataService: customService)
```

## プラットフォーム別の考慮事項 / Platform-Specific Considerations

### iOS / macOS / tvOS
- `ObservableObject`と`@Published`が利用可能
- SwiftUIと完全統合
- Combineフレームワークのサポート

### Linux / その他のプラットフォーム / Other Platforms
- 基本的なプロパティアクセス
- 非同期処理のサポート
- 手動での状態管理が必要

## まとめ / Summary

DailySNSWithYourSSは、クロスプラットフォーム対応のSwiftライブラリで、スクリーンショット共有SNSアプリケーションのコアロジックを提供します。iOS、macOS、watchOS、tvOSで動作し、将来的にはWebやAndroidへの展開も可能です。

DailySNSWithYourSS is a cross-platform Swift library that provides core logic for screenshot-sharing SNS applications. It works on iOS, macOS, watchOS, and tvOS, with potential for future expansion to Web and Android.
