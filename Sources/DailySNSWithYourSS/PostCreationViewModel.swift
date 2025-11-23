//
//  PostCreationViewModel.swift
//  DailySNSWithYourSS
//
//  Created on 2025-11-23.
//

import Foundation
#if canImport(Combine)
import Combine
#endif

/// ViewModel for managing post creation flow
@MainActor
public class PostCreationViewModel {
    #if canImport(Combine)
    @Published public var postItems: [PostItem] = []
    @Published public var isCreatingPost = false
    @Published public var currentItemType: PostItem.PostItemType = .screenshot
    #else
    public var postItems: [PostItem] = []
    public var isCreatingPost = false
    public var currentItemType: PostItem.PostItemType = .screenshot
    #endif
    
    public init() {}
    
    /// Add a screenshot to the post
    public func addScreenshot(imageURL: String) {
        let item = PostItem(type: .screenshot, content: imageURL)
        postItems.append(item)
        // Alternate to comment for next item
        currentItemType = .comment
    }
    
    /// Add a comment to the post
    public func addComment(text: String) {
        guard !text.isEmpty else { return }
        let item = PostItem(type: .comment, content: text)
        postItems.append(item)
        // Alternate to screenshot for next item
        currentItemType = .screenshot
    }
    
    /// Remove an item from the post (mark as deleted)
    public func removeItem(at index: Int) {
        guard index < postItems.count else { return }
        postItems[index].isDeleted = true
    }
    
    /// Remove an item by ID
    public func removeItem(id: UUID) {
        if let index = postItems.firstIndex(where: { $0.id == id }) {
            postItems.remove(at: index)
        }
    }
    
    /// Create the final post
    public func createPost(userId: String) -> Post {
        let activeItems = postItems.filter { !$0.isDeleted }
        return Post(userId: userId, items: activeItems)
    }
    
    /// Reset the creation state
    public func reset() {
        postItems.removeAll()
        currentItemType = .screenshot
        isCreatingPost = false
    }
    
    /// Check if post can be submitted (at least one screenshot, comments optional)
    public var canSubmit: Bool {
        let activeItems = postItems.filter { !$0.isDeleted }
        return activeItems.contains { $0.type == .screenshot }
    }
}
