# DailySNSWithYourSS

**日本語版**: スクリーンショットはあなたのインターネット上での活動の足跡です。それに対するコメントは日記となり、友達と共有することで会話のきっかけにもなります。

**English Version**: Screenshots are traces of your activities on the internet. Comments on them become a diary, and by sharing them with friends, they can also become conversation starters.

## 🌍 完全なクロスプラットフォーム対応 / Full Cross-Platform Support

このプロジェクトは**完全なクロスプラットフォーム対応**のスクリーンショット共有SNSアプリケーションです。

This project is a **fully cross-platform** screenshot-sharing SNS application.

### サポートプラットフォーム / Supported Platforms

- ✅ **iOS 15.0+** (Swift)
- ✅ **macOS 12.0+** (Swift)
- ✅ **watchOS 8.0+** (Swift)
- ✅ **tvOS 15.0+** (Swift)
- ✅ **Web** (TypeScript/JavaScript)
- ✅ **Android 7.0+** (Kotlin)

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
├── Package.swift                      # Swift Package (iOS/macOS/watchOS/tvOS)
├── Sources/DailySNSWithYourSS/        # Swift実装
│   ├── Models/
│   ├── ViewModels/
│   └── Services/
├── web/                               # Web版 (TypeScript)
│   ├── package.json
│   ├── tsconfig.json
│   └── src/
│       ├── models/
│       ├── viewmodels/
│       └── services/
├── android/                           # Android版 (Kotlin)
│   ├── app/build.gradle
│   └── app/src/main/java/com/dailysns/
│       ├── models/
│       ├── viewmodels/
│       └── services/
├── Tests/                             # テスト
├── README.md                          # このファイル
├── ARCHITECTURE.md                    # アーキテクチャドキュメント
├── EXAMPLES.md                        # 使用例
└── SUMMARY.md                         # 実装サマリー
```

## 🚀 クイックスタート / Quick Start

### iOS / macOS / watchOS / tvOS (Swift)

```bash
# Build the Swift package
swift build

# Run tests
swift test

# Or open in Xcode
open Package.swift
```

詳細は [ARCHITECTURE.md](ARCHITECTURE.md) を参照。

### Web版 (TypeScript)

```bash
cd web
npm install
npm run build
npm test
```

詳細は [web/README.md](web/README.md) を参照。

### Android版 (Kotlin)

```bash
cd android
./gradlew build
./gradlew test
```

詳細は [android/README.md](android/README.md) を参照。

## 📊 プラットフォーム別実装 / Platform Implementations

| Platform | Language | UI Framework | State Management |
|----------|----------|--------------|------------------|
| iOS/macOS/watchOS/tvOS | Swift | SwiftUI | Combine/@Published |
| Web | TypeScript | HTML/React | Observer Pattern |
| Android | Kotlin | Jetpack Compose | Flow/StateFlow |

## 🔧 技術スタック / Technology Stack

### Swift (Apple Platforms)
- Swift 5.9+
- Swift Package Manager
- Combine Framework
- Async/Await
- Codable/Sendable

### TypeScript (Web)
- TypeScript 5.0+
- ES2020
- Jest (Testing)
- ESLint

### Kotlin (Android)
- Kotlin 1.9+
- Jetpack Compose
- Kotlin Coroutines
- Kotlin Flow
- Kotlin Serialization

## 📖 ドキュメント / Documentation

- **[ARCHITECTURE.md](ARCHITECTURE.md)** - 詳細なアーキテクチャ説明（日英バイリンガル）
- **[EXAMPLES.md](EXAMPLES.md)** - 使用例とサンプルコード
- **[SUMMARY.md](SUMMARY.md)** - 実装サマリー
- **[web/README.md](web/README.md)** - Web版ドキュメント
- **[android/README.md](android/README.md)** - Android版ドキュメント

## 🧪 テスト / Testing

すべてのプラットフォームで包括的なテストを実装しています。

Comprehensive tests are implemented for all platforms.

```bash
# Swift (iOS/macOS/etc.)
swift test

# Web (TypeScript)
cd web && npm test

# Android (Kotlin)
cd android && ./gradlew test
```

## 📦 依存関係への追加 / Add as Dependency

### Swift Package Manager (iOS/macOS/watchOS/tvOS)

```swift
dependencies: [
    .package(url: "https://github.com/ymtezo/DailySNSWithYourSS.git", from: "1.0.0")
]
```

### npm (Web)

```json
{
  "dependencies": {
    "dailysns-web": "file:./path/to/web"
  }
}
```

### Gradle (Android)

```gradle
dependencies {
    implementation project(':dailysns-android')
}
```

## 🤝 コントリビューション / Contributing

プルリクエストを歓迎します！

Pull requests are welcome!

## 📄 ライセンス / License

See [LICENSE](LICENSE) file.

## 📞 お問い合わせ / Contact

Issue trackerをご利用ください。

Please use the issue tracker.
