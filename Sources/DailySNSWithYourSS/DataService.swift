//
//  DataService.swift
//  DailySNSWithYourSS
//
//  Created on 2025-11-23.
//

import Foundation

/// Protocol for data service operations - allows for different implementations per platform
public protocol DataServiceProtocol {
    func fetchAlbums() async throws -> [Album]
    func fetchRandomFollowingPosts(userId: String) async throws -> [Post]
    func fetchRandomGlobalPosts() async throws -> [Post]
    func createPost(_ post: Post) async throws -> Post
    func fetchUser(id: UUID) async throws -> User
}

/// Default data service implementation
public class DataService: DataServiceProtocol {
    public static let shared = DataService()
    
    private init() {}
    
    public func fetchAlbums() async throws -> [Album] {
        // Mock implementation - replace with actual API calls
        try await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
        return mockAlbums()
    }
    
    public func fetchRandomFollowingPosts(userId: String) async throws -> [Post] {
        // Mock implementation - replace with actual API calls
        try await Task.sleep(nanoseconds: 500_000_000)
        return mockPosts().filter { _ in Bool.random() }
    }
    
    public func fetchRandomGlobalPosts() async throws -> [Post] {
        // Mock implementation - replace with actual API calls
        try await Task.sleep(nanoseconds: 500_000_000)
        return mockPosts().shuffled()
    }
    
    public func createPost(_ post: Post) async throws -> Post {
        // Mock implementation - replace with actual API calls
        try await Task.sleep(nanoseconds: 500_000_000)
        return post
    }
    
    public func fetchUser(id: UUID) async throws -> User {
        // Mock implementation - replace with actual API calls
        try await Task.sleep(nanoseconds: 500_000_000)
        return mockUsers().first { $0.id == id } ?? mockUsers()[0]
    }
    
    // MARK: - Mock Data
    
    private func mockUsers() -> [User] {
        [
            User(username: "user1", displayName: "Alice"),
            User(username: "user2", displayName: "Bob"),
            User(username: "user3", displayName: "Charlie")
        ]
    }
    
    private func mockPosts() -> [Post] {
        let users = mockUsers()
        return users.flatMap { user in
            (0..<3).map { index in
                Post(
                    userId: user.id.uuidString,
                    items: [
                        PostItem(type: .screenshot, content: "screenshot_\(index).jpg"),
                        PostItem(type: .comment, content: "This is a comment \(index)")
                    ]
                )
            }
        }
    }
    
    private func mockAlbums() -> [Album] {
        let users = mockUsers()
        return users.map { user in
            Album(
                userId: user.id,
                userName: user.displayName,
                userProfileImageURL: user.profileImageURL,
                posts: mockPosts().filter { $0.userId == user.id.uuidString }
            )
        }
    }
}
