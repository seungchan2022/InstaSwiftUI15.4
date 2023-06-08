//
//  ProfileCellViewModel.swift
//  Instagram15.4
//
//  Created by 승찬 on 2023/06/08.
//

import Foundation

class ProfileCellViewModel: ObservableObject {
    @Published var posts = [Post]()
    private let user: User
    
    init(user: User) {
        self.user = user
        Task { try await fetchUserPosts() }
    }
    
    func fetchUserPosts() async throws {
        self.posts = try await PostService.fetchUserPosts(uid: user.id)
        
        for i in 0 ..< posts.count {
            posts[i].user = self.user
        }
    }
}
