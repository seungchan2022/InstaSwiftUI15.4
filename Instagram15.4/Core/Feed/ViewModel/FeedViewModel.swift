//
//  FeedViewModel.swift
//  Instagram15.4
//
//  Created by 승찬 on 2023/06/07.
//

import Foundation
import Firebase

class FeedViewModel: ObservableObject {
    @Published var posts = [Post]()
    
    init() {
        Task { try await fetchPosts() }
    }
    
    func fetchPosts() async throws {
        self.posts = try await PostService.fetchFeedPosts()
    }
}
