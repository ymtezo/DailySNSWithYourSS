//
//  User.swift
//  DailySNSWithYourSS
//
//  Created on 2025-11-23.
//

import Foundation

/// Represents a user in the SNS
public struct User: Identifiable, Codable, Sendable {
    public let id: UUID
    public let username: String
    public let displayName: String
    public let profileImageURL: String?
    public var followingIds: [UUID]
    public var followerIds: [UUID]
    public let createdAt: Date
    
    public init(id: UUID = UUID(), username: String, displayName: String, profileImageURL: String? = nil, followingIds: [UUID] = [], followerIds: [UUID] = [], createdAt: Date = Date()) {
        self.id = id
        self.username = username
        self.displayName = displayName
        self.profileImageURL = profileImageURL
        self.followingIds = followingIds
        self.followerIds = followerIds
        self.createdAt = createdAt
    }
}

/// Represents an album (collection of posts by a user)
public struct Album: Identifiable, Codable, Sendable {
    public let id: UUID
    public let userId: UUID
    public let userName: String
    public let userProfileImageURL: String?
    public let posts: [Post]
    public let createdAt: Date
    public var updatedAt: Date
    
    public init(id: UUID = UUID(), userId: UUID, userName: String, userProfileImageURL: String? = nil, posts: [Post] = [], createdAt: Date = Date(), updatedAt: Date = Date()) {
        self.id = id
        self.userId = userId
        self.userName = userName
        self.userProfileImageURL = userProfileImageURL
        self.posts = posts
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
