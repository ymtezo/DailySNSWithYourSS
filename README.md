# DailySNSWithYourSS

**日本語版**: スクリーンショットはあなたのインターネット上での活動の足跡です。それに対するコメントは日記となり、友達と共有することで会話のきっかけにもなります。

**English Version**: Screenshots are traces of your activities on the internet. Comments on them become a diary, and by sharing them with friends, they can also become conversation starters.

## 🌍 クロスプラットフォーム対応 / Cross-Platform Support

このプロジェクトはSwift Package Managerを使用した**クロスプラットフォーム対応**のライブラリです。

This project is a **cross-platform** library using Swift Package Manager.

### サポートプラットフォーム / Supported Platforms

- ✅ iOS 15.0+
- ✅ macOS 12.0+
- ✅ watchOS 8.0+
- ✅ tvOS 15.0+

## 📱 主な機能 / Main Features

### 1. 投稿作成機能 / Post Creation
- スクリーンショット → コメント → スクリーンショット → コメントの順に投稿
- Post in order: Screenshot → Comment → Screenshot → Comment
- 投稿したくないものは右上のバツ印で削除可能
- Unwanted items can be removed with X button in upper right
- コメントは任意（なくても投稿できる）
- Comments are optional (can post without comments)

### 2. アルバム閲覧タブ / Album Viewing Tab
- 他のユーザーのアルバムを選択して閲覧
- Select and view other users' albums
- アルバム一覧とアルバム詳細の表示
- Display album list and album details

### 3. ランダムフィードタブ / Random Feed Tab
- フォローしているユーザーの投稿をランダムに表示
- Display random posts from followed users
- 世界中のユーザーの投稿をランダムに表示
- Display random posts from users around the world

## 🏗️ プロジェクト構成 / Project Structure

```
DailySNSWithYourSS/
├── Package.swift                      # Swift Package configuration
├── Sources/DailySNSWithYourSS/
│   ├── Models/                        # Data models
│   │   ├── Post.swift                 # Post and PostItem
│   │   └── User.swift                 # User and Album
│   ├── ViewModels/                    # Business logic
│   │   ├── PostCreationViewModel.swift
│   │   ├── AlbumViewModel.swift
│   │   └── FeedViewModel.swift
│   └── Services/                      # Data services
│       └── DataService.swift
└── Tests/DailySNSWithYourSSTests/     # Unit tests
```

詳細なアーキテクチャについては [ARCHITECTURE.md](ARCHITECTURE.md) を参照してください。

For detailed architecture information, see [ARCHITECTURE.md](ARCHITECTURE.md).

## 🚀 クイックスタート / Quick Start

### ビルド / Build

```bash
# Build the package
swift build

# Run tests
swift test
```

### Xcodeで開く / Open in Xcode

```bash
# Generate Xcode project
swift package generate-xcodeproj

# Or open Package.swift directly in Xcode (recommended)
open Package.swift
```

### 使用例 / Usage Example

```swift
import DailySNSWithYourSS

// 投稿作成 / Create a post
let postVM = PostCreationViewModel()
postVM.addScreenshot(imageURL: "screenshot.jpg")
postVM.addComment(text: "Daily screenshot!")
let post = postVM.createPost(userId: "user123")

// アルバム閲覧 / View albums
let albumVM = AlbumViewModel()
albumVM.fetchAlbums()

// フィード表示 / Display feed
let feedVM = FeedViewModel(currentUserId: "user123")
feedVM.fetchPosts()
```

## 📦 依存関係への追加 / Add as Dependency

### Package.swift

```swift
dependencies: [
    .package(url: "https://github.com/ymtezo/DailySNSWithYourSS.git", from: "1.0.0")
]
```

## 🧪 テスト / Testing

```bash
# Run all tests
swift test

# Run tests with coverage
swift test --enable-code-coverage
```

## 📄 ライセンス / License

See [LICENSE](LICENSE) file.

## 🤝 コントリビューション / Contributing

プルリクエストを歓迎します！

Pull requests are welcome!

## 📞 お問い合わせ / Contact

Issue trackerをご利用ください。

Please use the issue tracker.

