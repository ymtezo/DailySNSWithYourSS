package com.dailysns.models

import kotlinx.serialization.Serializable
import java.util.UUID

/**
 * Post.kt
 * DailySNSWithYourSS Android版
 * 
 * 投稿とアイテムのデータモデル
 */

@Serializable
enum class PostItemType {
    SCREENSHOT,
    COMMENT
}

@Serializable
data class PostItem(
    val id: String = UUID.randomUUID().toString(),
    val type: PostItemType,
    val content: String, // Image URL for screenshot, text for comment
    val timestamp: Long = System.currentTimeMillis(),
    val isDeleted: Boolean = false
)

@Serializable
data class Post(
    val id: String = UUID.randomUUID().toString(),
    val userId: String,
    val items: List<PostItem> = emptyList(),
    val createdAt: Long = System.currentTimeMillis(),
    val updatedAt: Long = System.currentTimeMillis()
) {
    /**
     * アクティブなアイテム（削除されていない）を取得
     */
    val activeItems: List<PostItem>
        get() = items.filter { !it.isDeleted }
}
