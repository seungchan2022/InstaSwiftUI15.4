//
//  SearchViewModel.swift
//  Instagram15.4
//
//  Created by 승찬 on 2023/06/06.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        Task { try await fetchAllUsers() }
    }
    
    func fetchAllUsers() async throws {
        self.users = try await UserService.fetchAllUsers()
    }
}
