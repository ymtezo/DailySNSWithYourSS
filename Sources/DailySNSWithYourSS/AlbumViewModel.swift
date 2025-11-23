//
//  AlbumViewModel.swift
//  DailySNSWithYourSS
//
//  Created on 2025-11-23.
//

import Foundation
#if canImport(Combine)
import Combine
#endif

/// ViewModel for managing album viewing
@MainActor
public class AlbumViewModel {
    #if canImport(Combine)
    @Published public var albums: [Album] = []
    @Published public var selectedAlbum: Album?
    @Published public var isLoading = false
    @Published public var errorMessage: String?
    #else
    public var albums: [Album] = []
    public var selectedAlbum: Album?
    public var isLoading = false
    public var errorMessage: String?
    #endif
    
    private let dataService: DataServiceProtocol
    
    public init(dataService: DataServiceProtocol = DataService.shared) {
        self.dataService = dataService
    }
    
    /// Fetch all available albums from other users
    public func fetchAlbums() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let fetchedAlbums = try await dataService.fetchAlbums()
                await MainActor.run {
                    self.albums = fetchedAlbums
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
    
    /// Select an album to view
    public func selectAlbum(_ album: Album) {
        selectedAlbum = album
    }
    
    /// Clear the selected album
    public func clearSelection() {
        selectedAlbum = nil
    }
}
