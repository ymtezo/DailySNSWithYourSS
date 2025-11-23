package com.dailysns.viewmodels

import androidx.lifecycle.ViewModel
import com.dailysns.models.Post
import com.dailysns.models.PostItem
import com.dailysns.models.PostItemType
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow

/**
 * PostCreationViewModel.kt
 * DailySNSWithYourSS Android版
 * 
 * 投稿作成のビジネスロジック
 */

class PostCreationViewModel : ViewModel() {
    
    private val _postItems = MutableStateFlow<List<PostItem>>(emptyList())
    val postItems: StateFlow<List<PostItem>> = _postItems.asStateFlow()
    
    private val _isCreatingPost = MutableStateFlow(false)
    val isCreatingPost: StateFlow<Boolean> = _isCreatingPost.asStateFlow()
    
    private val _currentItemType = MutableStateFlow(PostItemType.SCREENSHOT)
    val currentItemType: StateFlow<PostItemType> = _currentItemType.asStateFlow()
    
    /**
     * スクリーンショットを追加
     */
    fun addScreenshot(imageURL: String) {
        val item = PostItem(type = PostItemType.SCREENSHOT, content = imageURL)
        _postItems.value = _postItems.value + item
        _currentItemType.value = PostItemType.COMMENT
    }
    
    /**
     * コメントを追加
     */
    fun addComment(text: String) {
        if (text.isBlank()) return
        val item = PostItem(type = PostItemType.COMMENT, content = text)
        _postItems.value = _postItems.value + item
        _currentItemType.value = PostItemType.SCREENSHOT
    }
    
    /**
     * アイテムを削除（インデックス指定）
     */
    fun removeItemAt(index: Int) {
        if (index in _postItems.value.indices) {
            _postItems.value = _postItems.value.toMutableList().apply {
                removeAt(index)
            }
        }
    }
    
    /**
     * アイテムを削除（ID指定）
     */
    fun removeItem(id: String) {
        _postItems.value = _postItems.value.filter { it.id != id }
    }
    
    /**
     * アクティブなアイテムを取得
     */
    private fun getActiveItems(): List<PostItem> {
        return _postItems.value.filter { !it.isDeleted }
    }
    
    /**
     * 投稿を作成
     */
    fun createPost(userId: String): Post {
        val activeItems = getActiveItems()
        return Post(userId = userId, items = activeItems)
    }
    
    /**
     * リセット
     */
    fun reset() {
        _postItems.value = emptyList()
        _currentItemType.value = PostItemType.SCREENSHOT
        _isCreatingPost.value = false
    }
    
    /**
     * 投稿可能かチェック（最低1つのスクリーンショットが必要）
     */
    val canSubmit: Boolean
        get() {
            val activeItems = getActiveItems()
            return activeItems.any { it.type == PostItemType.SCREENSHOT }
        }
}
