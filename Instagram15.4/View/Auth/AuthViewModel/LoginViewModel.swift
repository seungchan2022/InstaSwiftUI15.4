//
//  LoginViewModel.swift
//  Instagram15.4
//
//  Created by 승찬 on 2023/06/05.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func logIn() async throws {
        try await AuthService.shared.logIn(withEmail: email, password: password)
    }
}
