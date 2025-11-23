package com.dailysns.models

import kotlinx.serialization.Serializable
import java.util.UUID

/**
 * User.kt
 * DailySNSWithYourSS Android版
 * 
 * ユーザーとアルバムのデータモデル
 */

@Serializable
data class User(
    val id: String = UUID.randomUUID().toString(),
    val username: String,
    val displayName: String,
    val profileImageURL: String? = null,
    val followingIds: List<String> = emptyList(),
    val followerIds: List<String> = emptyList(),
    val createdAt: Long = System.currentTimeMillis()
)

@Serializable
data class Album(
    val id: String = UUID.randomUUID().toString(),
    val userId: String,
    val userName: String,
    val userProfileImageURL: String? = null,
    val posts: List<Post> = emptyList(),
    val createdAt: Long = System.currentTimeMillis(),
    val updatedAt: Long = System.currentTimeMillis()
)
