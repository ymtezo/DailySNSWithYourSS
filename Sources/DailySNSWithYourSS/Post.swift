//
//  Post.swift
//  DailySNSWithYourSS
//
//  Created on 2025-11-23.
//

import Foundation

/// Represents a single post item (screenshot or comment)
public struct PostItem: Identifiable, Codable, Sendable {
    public let id: UUID
    public let type: PostItemType
    public let content: String // Image URL for screenshot, text for comment
    public let timestamp: Date
    public var isDeleted: Bool = false
    
    public enum PostItemType: String, Codable, Sendable {
        case screenshot
        case comment
    }
    
    public init(id: UUID = UUID(), type: PostItemType, content: String, timestamp: Date = Date()) {
        self.id = id
        self.type = type
        self.content = content
        self.timestamp = timestamp
    }
}

/// Represents a complete post with multiple items (screenshots and comments)
public struct Post: Identifiable, Codable, Sendable {
    public let id: UUID
    public let userId: String
    public var items: [PostItem]
    public let createdAt: Date
    public var updatedAt: Date
    
    public init(id: UUID = UUID(), userId: String, items: [PostItem] = [], createdAt: Date = Date(), updatedAt: Date = Date()) {
        self.id = id
        self.userId = userId
        self.items = items
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    /// Get all non-deleted items
    public var activeItems: [PostItem] {
        items.filter { !$0.isDeleted }
    }
}
