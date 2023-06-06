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
        
        // 유저 생성후 다시 유저를 생성하려는데 이전에 작성했던 것들이 남아있으므로 초기화 시켜줌
        username = ""
        email = ""
        password = ""
    }
}
