//
//  UserService.swift
//  Instagram15.4
//
//  Created by 승찬 on 2023/06/06.
//

import Foundation
import Firebase

struct UserService {
    
    static func fetchAllUsers() async throws -> [User] {
        var users = [User]()
        
        // users에 대한 모든 snapshot 데이터
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        let documents = snapshot.documents
        
        for doc in documents {
            guard let user = try? doc.data(as: User.self) else { return users } // 반환값이 void가 아니므로 else에 users를 넣음
            users.append(user)  // => 여러 데이터를 얻으려고 하므로 단일 데이터를 배열에 넣으면 된다.
        }
        
        return users
//        return snapshot.documents.compactMap({ try? $0.data(as: User.self)})
    }
}
