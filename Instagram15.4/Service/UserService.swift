//
//  UserService.swift
//  Instagram15.4
//
//  Created by 승찬 on 2023/06/06.
//

import Foundation
import Firebase

struct UserService {
    
    // uid를 통해 하나의 유저만 불러오도록
    static func fetchUser(withUid uid: String) async throws -> User {
        let snapshot = try await COLLECTION_USERS.document(uid).getDocument()
        return try snapshot.data(as: User.self)
    }
    
    static func fetchAllUsers() async throws -> [User] {
        var users = [User]()
        
        // users에 대한 모든 snapshot 데이터
        let snapshot = try await COLLECTION_USERS.getDocuments()
        let documents = snapshot.documents
        
        for doc in documents {
            guard let user = try? doc.data(as: User.self) else { return users } // 반환값이 void가 아니므로 else에 users를 넣음
            users.append(user)  // => 여러 데이터를 얻으려고 하므로 단일 데이터를 배열에 넣으면 된다.
        }
        
        return users
//        return snapshot.documents.compactMap({ try? $0.data(as: User.self)})
    }
    
    // follow 하는 과정: => following -> currentUid -> user-following -> uid
    // follow를 하면 following과 follwers가 동시에 설정된다
    static func follow(uid: String) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        try await COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).setData([:])
        
        try await COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).setData([:])
        
    }
}
