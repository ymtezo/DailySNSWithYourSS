package com.dailysns.viewmodels

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.dailysns.models.Album
import com.dailysns.services.DataService
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch

/**
 * AlbumViewModel.kt
 * DailySNSWithYourSS Android版
 * 
 * アルバム閲覧のビジネスロジック
 */

class AlbumViewModel(
    private val dataService: DataService = DataService()
) : ViewModel() {
    
    private val _albums = MutableStateFlow<List<Album>>(emptyList())
    val albums: StateFlow<List<Album>> = _albums.asStateFlow()
    
    private val _selectedAlbum = MutableStateFlow<Album?>(null)
    val selectedAlbum: StateFlow<Album?> = _selectedAlbum.asStateFlow()
    
    private val _isLoading = MutableStateFlow(false)
    val isLoading: StateFlow<Boolean> = _isLoading.asStateFlow()
    
    private val _errorMessage = MutableStateFlow<String?>(null)
    val errorMessage: StateFlow<String?> = _errorMessage.asStateFlow()
    
    /**
     * アルバムを取得
     */
    fun fetchAlbums() {
        viewModelScope.launch {
            _isLoading.value = true
            _errorMessage.value = null
            
            try {
                _albums.value = dataService.fetchAlbums()
            } catch (e: Exception) {
                _errorMessage.value = e.message
            } finally {
                _isLoading.value = false
            }
        }
    }
    
    /**
     * アルバムを選択
     */
    fun selectAlbum(album: Album) {
        _selectedAlbum.value = album
    }
    
    /**
     * 選択をクリア
     */
    fun clearSelection() {
        _selectedAlbum.value = null
    }
}
