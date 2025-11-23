//
//  FeedViewModel.swift
//  DailySNSWithYourSS
//
//  Created on 2025-11-23.
//

import Foundation
#if canImport(Combine)
import Combine
#endif

/// ViewModel for managing the random feed
@MainActor
public class FeedViewModel {
    #if canImport(Combine)
    @Published public var posts: [Post] = []
    @Published public var feedType: FeedType = .following
    @Published public var isLoading = false
    @Published public var errorMessage: String?
    #else
    public var posts: [Post] = []
    public var feedType: FeedType = .following
    public var isLoading = false
    public var errorMessage: String?
    #endif
    
    private let dataService: DataServiceProtocol
    private let currentUserId: String
    
    public enum FeedType {
        case following  // Posts from followed users
        case global     // Posts from anyone globally
    }
    
    public init(currentUserId: String, dataService: DataServiceProtocol = DataService.shared) {
        self.currentUserId = currentUserId
        self.dataService = dataService
    }
    
    /// Fetch random posts based on current feed type
    public func fetchPosts() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let fetchedPosts: [Post]
                switch feedType {
                case .following:
                    fetchedPosts = try await dataService.fetchRandomFollowingPosts(userId: currentUserId)
                case .global:
                    fetchedPosts = try await dataService.fetchRandomGlobalPosts()
                }
                
                await MainActor.run {
                    self.posts = fetchedPosts
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }
    
    /// Switch between following and global feed
    public func switchFeedType(to type: FeedType) {
        guard feedType != type else { return }
        feedType = type
        fetchPosts()
    }
    
    /// Refresh the current feed
    public func refresh() {
        fetchPosts()
    }
}
