# DailySNSWithYourSS - Android版

Kotlinで実装された、クロスプラットフォーム対応のスクリーンショット共有SNSアプリケーションのAndroid版です。

## セットアップ / Setup

### 要件 / Requirements

- Android Studio Hedgehog | 2023.1.1以降
- Kotlin 1.9.0以降
- Android SDK 24以降（Android 7.0 Nougat）
- Target SDK 34（Android 14）

### ビルド / Build

```bash
cd android
./gradlew build
```

### テスト / Test

```bash
./gradlew test
```

## プロジェクト構成 / Project Structure

```
android/
└── app/
    ├── build.gradle
    └── src/
        └── main/
            └── java/com/dailysns/
                ├── models/
                │   ├── Post.kt
                │   └── User.kt
                ├── viewmodels/
                │   ├── PostCreationViewModel.kt
                │   ├── AlbumViewModel.kt
                │   └── FeedViewModel.kt
                └── services/
                    └── DataService.kt
```

## 使用例 / Usage Example

### 投稿作成 / Post Creation

```kotlin
import com.dailysns.viewmodels.PostCreationViewModel

class PostCreationActivity : ComponentActivity() {
    private val viewModel: PostCreationViewModel by viewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        // スクリーンショットを追加
        viewModel.addScreenshot("screenshot1.jpg")
        
        // コメントを追加
        viewModel.addComment("今日のスクリーンショット")
        
        // 投稿を作成
        lifecycleScope.launch {
            viewModel.postItems.collect { items ->
                if (viewModel.canSubmit) {
                    val post = viewModel.createPost("user123")
                    Log.d("Post", "Created: ${post.id}")
                }
            }
        }
    }
}
```

### Jetpack Compose UI

```kotlin
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue

@Composable
fun PostCreationScreen(
    viewModel: PostCreationViewModel = viewModel()
) {
    val items by viewModel.postItems.collectAsState()
    val canSubmit = viewModel.canSubmit

    Column(modifier = Modifier.padding(16.dp)) {
        Text("投稿作成", style = MaterialTheme.typography.headlineMedium)
        
        LazyColumn {
            items(items) { item ->
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.SpaceBetween
                ) {
                    Text("${item.type}: ${item.content}")
                    IconButton(onClick = { viewModel.removeItem(item.id) }) {
                        Icon(Icons.Default.Close, contentDescription = "削除")
                    }
                }
            }
        }
        
        Row {
            Button(onClick = { viewModel.addScreenshot("test.jpg") }) {
                Text("スクリーンショット追加")
            }
            
            Button(
                onClick = { /* 投稿処理 */ },
                enabled = canSubmit
            ) {
                Text("投稿")
            }
        }
    }
}
```

### アルバム閲覧 / Album Viewing

```kotlin
@Composable
fun AlbumListScreen(
    viewModel: AlbumViewModel = viewModel()
) {
    val albums by viewModel.albums.collectAsState()
    val isLoading by viewModel.isLoading.collectAsState()
    val errorMessage by viewModel.errorMessage.collectAsState()

    LaunchedEffect(Unit) {
        viewModel.fetchAlbums()
    }

    when {
        isLoading -> CircularProgressIndicator()
        errorMessage != null -> Text("エラー: $errorMessage")
        else -> {
            LazyColumn {
                items(albums) { album ->
                    AlbumItem(album) {
                        viewModel.selectAlbum(album)
                    }
                }
            }
        }
    }
}
```

### フィード表示 / Feed Display

```kotlin
@Composable
fun FeedScreen(
    viewModel: FeedViewModel = viewModel { FeedViewModel("user123") }
) {
    val posts by viewModel.posts.collectAsState()
    val feedType by viewModel.feedType.collectAsState()
    val isLoading by viewModel.isLoading.collectAsState()

    Column {
        // フィードタイプ切り替え
        Row {
            Button(onClick = { viewModel.switchFeedType(FeedType.FOLLOWING) }) {
                Text("フォロー中")
            }
            Button(onClick = { viewModel.switchFeedType(FeedType.GLOBAL) }) {
                Text("グローバル")
            }
        }

        if (isLoading) {
            CircularProgressIndicator()
        } else {
            LazyColumn {
                items(posts) { post ->
                    PostItem(post)
                }
            }
        }
    }
}
```

## 技術スタック / Technology Stack

- **Kotlin 1.9.0**: モダンなAndroid開発言語
- **Jetpack Compose**: 宣言的UI
- **Kotlin Coroutines**: 非同期処理
- **Kotlin Flow**: リアクティブデータストリーム
- **ViewModel**: ライフサイクル対応データ管理
- **Kotlin Serialization**: JSONシリアライゼーション

## 依存関係 / Dependencies

- AndroidX Core KTX
- Lifecycle Runtime KTX
- Jetpack Compose BOM
- Material3
- Kotlin Coroutines
- Kotlin Serialization

## ライセンス / License

See LICENSE file
