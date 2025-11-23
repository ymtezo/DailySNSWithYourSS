# DailySNSWithYourSS - Web版

TypeScriptで実装された、クロスプラットフォーム対応のスクリーンショット共有SNSアプリケーションのWeb版です。

## セットアップ / Setup

### インストール / Installation

```bash
cd web
npm install
```

### ビルド / Build

```bash
npm run build
```

### 開発モード / Development

```bash
npm run dev
```

### テスト / Test

```bash
npm test
```

## プロジェクト構成 / Project Structure

```
web/
├── src/
│   ├── models/
│   │   ├── Post.ts          # 投稿データモデル
│   │   └── User.ts          # ユーザー/アルバムモデル
│   ├── viewmodels/
│   │   ├── PostCreationViewModel.ts
│   │   ├── AlbumViewModel.ts
│   │   └── FeedViewModel.ts
│   └── services/
│       └── DataService.ts   # データサービス
├── package.json
└── tsconfig.json
```

## 使用例 / Usage Example

### 投稿作成 / Post Creation

```typescript
import { PostCreationViewModel } from './viewmodels/PostCreationViewModel';

const viewModel = new PostCreationViewModel();

// スクリーンショットを追加
viewModel.addScreenshot('screenshot1.jpg');

// コメントを追加
viewModel.addComment('今日のスクリーンショット');

// 投稿を作成
if (viewModel.canSubmit) {
    const post = viewModel.createPost('user123');
    console.log('投稿作成:', post);
}
```

### アルバム閲覧 / Album Viewing

```typescript
import { AlbumViewModel } from './viewmodels/AlbumViewModel';

const viewModel = new AlbumViewModel();

// 変更を監視
viewModel.subscribe(() => {
    console.log('Albums:', viewModel.albums);
    console.log('Loading:', viewModel.isLoading);
});

// アルバムを取得
await viewModel.fetchAlbums();

// アルバムを選択
if (viewModel.albums.length > 0) {
    viewModel.selectAlbum(viewModel.albums[0]);
}
```

### フィード表示 / Feed Display

```typescript
import { FeedViewModel, FeedType } from './viewmodels/FeedViewModel';

const viewModel = new FeedViewModel('user123');

// 変更を監視
viewModel.subscribe(() => {
    console.log('Posts:', viewModel.posts);
});

// 投稿を取得
await viewModel.fetchPosts();

// グローバルフィードに切り替え
await viewModel.switchFeedType(FeedType.Global);
```

## React統合例 / React Integration

```typescript
import React, { useEffect, useState } from 'react';
import { PostCreationViewModel } from './viewmodels/PostCreationViewModel';

function PostCreationComponent() {
    const [viewModel] = useState(() => new PostCreationViewModel());
    const [items, setItems] = useState(viewModel.postItems);

    useEffect(() => {
        const unsubscribe = viewModel.subscribe(() => {
            setItems([...viewModel.postItems]);
        });
        return unsubscribe;
    }, [viewModel]);

    return (
        <div>
            <h2>投稿作成</h2>
            <ul>
                {items.map(item => (
                    <li key={item.id}>
                        {item.type}: {item.content}
                        <button onClick={() => viewModel.removeItem(item.id)}>
                            削除
                        </button>
                    </li>
                ))}
            </ul>
            <button onClick={() => viewModel.addScreenshot('test.jpg')}>
                スクリーンショット追加
            </button>
            <button disabled={!viewModel.canSubmit}>
                投稿
            </button>
        </div>
    );
}
```

## 技術スタック / Technology Stack

- **TypeScript 5.0+**: 型安全な開発
- **ES2020**: モダンJavaScript機能
- **Jest**: テストフレームワーク
- **ESLint**: コード品質管理

## ライセンス / License

See LICENSE file
