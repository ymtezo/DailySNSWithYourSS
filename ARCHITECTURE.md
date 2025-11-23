# DailySNSWithYourSS - クロスプラットフォーム対応アーキテクチャ

## 概要 / Overview

**日本語**: スクリーンショット共有SNSアプリケーション。クロスプラットフォーム対応で、iOS、macOS、watchOS、tvOSで動作します。

**English**: A screenshot-sharing SNS application with cross-platform support for iOS, macOS, watchOS, and tvOS.

## プロジェクト構成 / Project Structure

```
DailySNSWithYourSS/
├── Package.swift                 # Swift Package Manager configuration
├── Sources/
│   └── DailySNSWithYourSS/
│       ├── Models/
│       │   ├── Post.swift        # Post and PostItem models
│       │   └── User.swift        # User and Album models
│       ├── ViewModels/
│       │   ├── PostCreationViewModel.swift
│       │   ├── AlbumViewModel.swift
│       │   └── FeedViewModel.swift
│       └── Services/
│           └── DataService.swift # Data service protocol and implementation
└── Tests/
    └── DailySNSWithYourSSTests/
```

## 主要機能 / Main Features

### 1. 投稿作成 / Post Creation
- スクリーンショットとコメントを交互に投稿
- Screenshot and comment posting in alternating order
- 右上のバツ印で削除可能 / Can delete with X button in upper right
- コメントは任意 / Comments are optional

### 2. アルバム閲覧タブ / Album Viewing Tab
- 他のユーザーのアルバムを選択して表示
- Select and view other users' albums
- アルバム一覧とアルバム詳細ビュー
- Album list and detail views

### 3. ランダムフィードタブ / Random Feed Tab
- フォロー中のユーザーからランダム表示
- Random display from followed users
- 世界中のユーザーからランダム表示
- Random display from global users

## プラットフォーム対応 / Platform Support

このプロジェクトは Swift Package Manager を使用し、以下のプラットフォームをサポートします：
This project uses Swift Package Manager and supports the following platforms:

- **iOS 15.0+**
- **macOS 12.0+**
- **watchOS 8.0+**
- **tvOS 15.0+**

## アーキテクチャ / Architecture

### MVVM パターン
- **Models**: データ構造の定義 (Post, User, Album)
- **ViewModels**: ビジネスロジックと状態管理
- **Services**: データ取得とAPI通信

### 主要コンポーネント / Key Components

#### Models
- `Post`: 投稿データ（複数のPostItemを含む）
- `PostItem`: 個別のアイテム（スクリーンショットまたはコメント）
- `User`: ユーザー情報
- `Album`: ユーザーのアルバム（投稿のコレクション）

#### ViewModels
- `PostCreationViewModel`: 投稿作成の状態管理
- `AlbumViewModel`: アルバム表示の状態管理
- `FeedViewModel`: フィード表示の状態管理（フォロー/グローバル切り替え）

#### Services
- `DataServiceProtocol`: データサービスのインターフェース
- `DataService`: データ取得の実装（現在はモックデータ）

## ビルド方法 / How to Build

### Swift Package Manager
```bash
# Build the package
swift build

# Run tests
swift test

# Generate Xcode project
swift package generate-xcodeproj
```

### Xcode
1. Open `Package.swift` in Xcode
2. Select target platform (iOS, macOS, etc.)
3. Build and run

## 使用方法 / Usage

### パッケージのインポート / Importing the Package

```swift
import DailySNSWithYourSS

// Create a post creation view model
let postVM = PostCreationViewModel()

// Add a screenshot
postVM.addScreenshot(imageURL: "path/to/screenshot.jpg")

// Add a comment (optional)
postVM.addComment(text: "This is my daily screenshot!")

// Create the post
let post = postVM.createPost(userId: "user123")
```

### アルバム表示 / Album Display

```swift
import DailySNSWithYourSS

// Create album view model
let albumVM = AlbumViewModel()

// Fetch albums
albumVM.fetchAlbums()

// Select an album to view
if let album = albumVM.albums.first {
    albumVM.selectAlbum(album)
}
```

### フィード表示 / Feed Display

```swift
import DailySNSWithYourSS

// Create feed view model
let feedVM = FeedViewModel(currentUserId: "user123")

// Fetch following feed
feedVM.fetchPosts()

// Switch to global feed
feedVM.switchFeedType(to: .global)
```

## 今後の拡張 / Future Enhancements

- [ ] 実際のバックエンドAPI統合 / Real backend API integration
- [ ] 画像アップロード機能 / Image upload functionality
- [ ] プッシュ通知 / Push notifications
- [ ] リアルタイム更新 / Real-time updates
- [ ] ユーザー認証 / User authentication
- [ ] オフラインサポート / Offline support
- [ ] UIコンポーネント（SwiftUI Views） / UI components (SwiftUI Views)
- [ ] Web版（WebAssembly対応） / Web version (WebAssembly support)
- [ ] Android版（Kotlin Multiplatform対応） / Android version (Kotlin Multiplatform support)

## ライセンス / License

See LICENSE file

## 開発者向けノート / Developer Notes

### データモデルの特徴 / Data Model Features

- すべてのモデルは`Codable`プロトコルに準拠し、JSONシリアライゼーションをサポート
- All models conform to `Codable` protocol for JSON serialization
- `Sendable`プロトコルに準拠し、並行処理をサポート
- Conform to `Sendable` protocol for concurrency support
- `public`アクセス修飾子により、他のモジュールから利用可能
- Use `public` access modifiers for use from other modules

### ViewModelsの設計 / ViewModel Design

- `@MainActor`により、UIの更新は常にメインスレッドで実行
- `@MainActor` ensures UI updates always run on main thread
- `ObservableObject`により、SwiftUIと連携
- `ObservableObject` for SwiftUI integration
- 依存性注入をサポート（テストが容易）
- Support dependency injection (easy to test)

### クロスプラットフォーム対応の考慮事項 / Cross-Platform Considerations

- プラットフォーム固有のUI実装は含まれていません
- Platform-specific UI implementations are not included
- ビジネスロジックとデータレイヤーのみを提供
- Provides only business logic and data layer
- 各プラットフォーム用のUIは別途実装が必要
- UI for each platform needs to be implemented separately
