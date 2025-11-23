package com.dailysns.services

import com.dailysns.models.*
import kotlinx.coroutines.delay

/**
 * DataService.kt
 * DailySNSWithYourSS Android版
 * 
 * データサービス（モック実装）
 */

interface DataServiceProtocol {
    suspend fun fetchAlbums(): List<Album>
    suspend fun fetchRandomFollowingPosts(userId: String): List<Post>
    suspend fun fetchRandomGlobalPosts(): List<Post>
    suspend fun createPost(post: Post): Post
    suspend fun fetchUser(id: String): User
}

class DataService : DataServiceProtocol {
    
    /**
     * アルバムを取得（モック）
     */
    override suspend fun fetchAlbums(): List<Album> {
        delay(500)
        return mockAlbums()
    }
    
    /**
     * フォロー中のユーザーの投稿を取得（モック）
     */
    override suspend fun fetchRandomFollowingPosts(userId: String): List<Post> {
        delay(500)
        val allPosts = mockPosts()
        return allPosts.take(minOf(5, allPosts.size))
    }
    
    /**
     * グローバル投稿を取得（モック）
     */
    override suspend fun fetchRandomGlobalPosts(): List<Post> {
        delay(500)
        return mockPosts()
    }
    
    /**
     * 投稿を作成（モック）
     */
    override suspend fun createPost(post: Post): Post {
        delay(500)
        return post
    }
    
    /**
     * ユーザーを取得（モック）
     */
    override suspend fun fetchUser(id: String): User {
        delay(500)
        return mockUsers().find { it.id == id }
            ?: User(username = "unknown", displayName = "Unknown User")
    }
    
    // モックデータ生成
    
    private fun mockUsers(): List<User> {
        return listOf(
            User(id = "1", username = "user1", displayName = "Alice"),
            User(id = "2", username = "user2", displayName = "Bob"),
            User(id = "3", username = "user3", displayName = "Charlie")
        )
    }
    
    private fun mockPosts(): List<Post> {
        val users = mockUsers()
        val posts = mutableListOf<Post>()
        
        users.forEach { user ->
            repeat(3) { i ->
                val items = listOf(
                    PostItem(type = PostItemType.SCREENSHOT, content = "screenshot_$i.jpg"),
                    PostItem(type = PostItemType.COMMENT, content = "This is a comment $i")
                )
                posts.add(Post(userId = user.id, items = items))
            }
        }
        
        return posts
    }
    
    private fun mockAlbums(): List<Album> {
        val users = mockUsers()
        return users.map { user ->
            val userPosts = mockPosts().filter { it.userId == user.id }
            Album(
                userId = user.id,
                userName = user.displayName,
                userProfileImageURL = user.profileImageURL,
                posts = userPosts
            )
        }
    }
}
