package com.dailysns.viewmodels

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.dailysns.models.Post
import com.dailysns.services.DataService
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch

/**
 * FeedViewModel.kt
 * DailySNSWithYourSS Android版
 * 
 * フィード表示のビジネスロジック
 */

enum class FeedType {
    FOLLOWING,
    GLOBAL
}

class FeedViewModel(
    private val currentUserId: String,
    private val dataService: DataService = DataService()
) : ViewModel() {
    
    private val _posts = MutableStateFlow<List<Post>>(emptyList())
    val posts: StateFlow<List<Post>> = _posts.asStateFlow()
    
    private val _feedType = MutableStateFlow(FeedType.FOLLOWING)
    val feedType: StateFlow<FeedType> = _feedType.asStateFlow()
    
    private val _isLoading = MutableStateFlow(false)
    val isLoading: StateFlow<Boolean> = _isLoading.asStateFlow()
    
    private val _errorMessage = MutableStateFlow<String?>(null)
    val errorMessage: StateFlow<String?> = _errorMessage.asStateFlow()
    
    /**
     * 投稿を取得
     */
    fun fetchPosts() {
        viewModelScope.launch {
            _isLoading.value = true
            _errorMessage.value = null
            
            try {
                _posts.value = when (_feedType.value) {
                    FeedType.FOLLOWING -> dataService.fetchRandomFollowingPosts(currentUserId)
                    FeedType.GLOBAL -> dataService.fetchRandomGlobalPosts()
                }
            } catch (e: Exception) {
                _errorMessage.value = e.message
            } finally {
                _isLoading.value = false
            }
        }
    }
    
    /**
     * フィードタイプを切り替え
     */
    fun switchFeedType(type: FeedType) {
        if (_feedType.value == type) return
        _feedType.value = type
        fetchPosts()
    }
    
    /**
     * 更新
     */
    fun refresh() {
        fetchPosts()
    }
}
