//
//  ContentViewModel.swift
//  Instagram15.4
//
//  Created by 승찬 on 2023/06/05.
//

import Foundation
import Firebase
import Combine

// authservice가 퍼블리셔이고 contenviewmodel이 서브스크라이버로 contentViewModel이 authservice에게 usersession에 대한 데이터를 요청하면서 combine을 사용하여 구독하는 그림

class ContentViewModel: ObservableObject {
    
    private var service = AuthService.shared
    private var cancellables = Set<AnyCancellable>()
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        setupSubscribers()
    }
    
    func setupSubscribers() {
        service.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
        }.store(in: &cancellables)
        
        // AuthService에 대한 데이터를 사용하기 위해 구독을 해야 된다.
        service.$currentUser.sink { [weak self] currentUser in
            self?.currentUser = currentUser
        }.store(in: &cancellables)
    }
    
    
}
