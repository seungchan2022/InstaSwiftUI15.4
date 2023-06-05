//
//  RegistrationViewModel.swift
//  Instagram15.4
//
//  Created by 승찬 on 2023/06/05.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    
    func createUser() async throws {
        try await AuthService.shared.createUser(email: email, password: password, username: username)
    }
}
