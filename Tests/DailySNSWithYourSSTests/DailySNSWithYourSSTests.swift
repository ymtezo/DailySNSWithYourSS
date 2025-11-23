import Testing
import Foundation
@testable import DailySNSWithYourSS

// MARK: - Model Tests

@Test func testPostItemCreation() {
    let screenshot = PostItem(type: .screenshot, content: "test.jpg")
    #expect(screenshot.type == .screenshot)
    #expect(screenshot.content == "test.jpg")
    #expect(screenshot.isDeleted == false)
}

@Test func testPostCreation() {
    let items = [
        PostItem(type: .screenshot, content: "screenshot1.jpg"),
        PostItem(type: .comment, content: "Test comment")
    ]
    let post = Post(userId: "user123", items: items)
    
    #expect(post.userId == "user123")
    #expect(post.items.count == 2)
    #expect(post.activeItems.count == 2)
}

@Test func testPostActiveItems() {
    var items = [
        PostItem(type: .screenshot, content: "screenshot1.jpg"),
        PostItem(type: .comment, content: "Test comment")
    ]
    items[0].isDeleted = true
    
    let post = Post(userId: "user123", items: items)
    #expect(post.activeItems.count == 1)
    #expect(post.activeItems.first?.type == .comment)
}

@Test func testUserCreation() {
    let user = User(username: "testuser", displayName: "Test User")
    #expect(user.username == "testuser")
    #expect(user.displayName == "Test User")
    #expect(user.followingIds.isEmpty)
    #expect(user.followerIds.isEmpty)
}

@Test func testAlbumCreation() {
    let userId = UUID()
    let album = Album(userId: userId, userName: "Test User")
    #expect(album.userId == userId)
    #expect(album.userName == "Test User")
    #expect(album.posts.isEmpty)
}

// MARK: - ViewModel Tests

@Test @MainActor func testPostCreationViewModelAddScreenshot() {
    let viewModel = PostCreationViewModel()
    viewModel.addScreenshot(imageURL: "test.jpg")
    
    #expect(viewModel.postItems.count == 1)
    #expect(viewModel.postItems.first?.type == .screenshot)
    #expect(viewModel.currentItemType == .comment)
}

@Test @MainActor func testPostCreationViewModelAddComment() {
    let viewModel = PostCreationViewModel()
    viewModel.addComment(text: "Test comment")
    
    #expect(viewModel.postItems.count == 1)
    #expect(viewModel.postItems.first?.type == .comment)
    #expect(viewModel.currentItemType == .screenshot)
}

@Test @MainActor func testPostCreationViewModelRemoveItem() {
    let viewModel = PostCreationViewModel()
    viewModel.addScreenshot(imageURL: "test.jpg")
    
    let itemId = viewModel.postItems.first!.id
    viewModel.removeItem(id: itemId)
    
    #expect(viewModel.postItems.isEmpty)
}

@Test @MainActor func testPostCreationViewModelCanSubmit() {
    let viewModel = PostCreationViewModel()
    #expect(viewModel.canSubmit == false)
    
    viewModel.addScreenshot(imageURL: "test.jpg")
    #expect(viewModel.canSubmit == true)
    
    viewModel.addComment(text: "Comment")
    #expect(viewModel.canSubmit == true)
}

@Test @MainActor func testPostCreationViewModelReset() {
    let viewModel = PostCreationViewModel()
    viewModel.addScreenshot(imageURL: "test.jpg")
    viewModel.isCreatingPost = true
    
    viewModel.reset()
    
    #expect(viewModel.postItems.isEmpty)
    #expect(viewModel.isCreatingPost == false)
    #expect(viewModel.currentItemType == .screenshot)
}

@Test @MainActor func testAlbumViewModelSelectAlbum() {
    let viewModel = AlbumViewModel()
    let album = Album(userId: UUID(), userName: "Test User")
    
    viewModel.selectAlbum(album)
    #expect(viewModel.selectedAlbum != nil)
    #expect(viewModel.selectedAlbum?.userName == "Test User")
    
    viewModel.clearSelection()
    #expect(viewModel.selectedAlbum == nil)
}

@Test @MainActor func testFeedViewModelSwitchFeedType() async {
    let viewModel = FeedViewModel(currentUserId: "user123")
    #expect(viewModel.feedType == .following)
    
    viewModel.switchFeedType(to: .global)
    #expect(viewModel.feedType == .global)
}

// MARK: - Codable Tests

@Test func testPostItemCodable() throws {
    let item = PostItem(type: .screenshot, content: "test.jpg")
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    let data = try encoder.encode(item)
    let decoded = try decoder.decode(PostItem.self, from: data)
    
    #expect(item.id == decoded.id)
    #expect(item.type == decoded.type)
    #expect(item.content == decoded.content)
}

@Test func testPostCodable() throws {
    let items = [PostItem(type: .screenshot, content: "test.jpg")]
    let post = Post(userId: "user123", items: items)
    
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    let data = try encoder.encode(post)
    let decoded = try decoder.decode(Post.self, from: data)
    
    #expect(post.id == decoded.id)
    #expect(post.userId == decoded.userId)
    #expect(post.items.count == decoded.items.count)
}

@Test func testUserCodable() throws {
    let user = User(username: "testuser", displayName: "Test User")
    
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    let data = try encoder.encode(user)
    let decoded = try decoder.decode(User.self, from: data)
    
    #expect(user.id == decoded.id)
    #expect(user.username == decoded.username)
    #expect(user.displayName == decoded.displayName)
}

// MARK: - Data Service Tests

@Test func testDataServiceFetchAlbums() async throws {
    let service = DataService.shared
    let albums = try await service.fetchAlbums()
    
    #expect(!albums.isEmpty)
}

@Test func testDataServiceFetchRandomPosts() async throws {
    let service = DataService.shared
    let posts = try await service.fetchRandomGlobalPosts()
    
    #expect(!posts.isEmpty)
}
