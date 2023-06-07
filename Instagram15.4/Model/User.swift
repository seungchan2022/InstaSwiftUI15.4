//
//  User.swift
//  Instagram15.4
//
//  Created by 승찬 on 2023/06/01.
//

import Foundation
import Firebase

struct User: Identifiable, Hashable, Codable {
    let id: String
    var username: String
    var fullname: String?
    var bio: String?
    var profileImageUrl: String?
    let email: String
    
    var isCurrentUser: Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else { return false }
        return currentUid == id
    }
}

// 아이언맨, 그루트, 조커, 스파이터맨, 베놈

extension User {
    static var MOCK_USERS: [User] = [
        .init(id: NSUUID().uuidString, username: "ironman", fullname: "Tony Stark", bio: "ironman bio",profileImageUrl: nil, email: "ironman@gmail.com"),
        .init(id: NSUUID().uuidString, username: "groot", fullname: nil, bio: "ironman bio", profileImageUrl: nil, email: "groot@gmail.com"),
        .init(id: NSUUID().uuidString, username: "joker", fullname: "Heath Ledger", bio: "ironman bio",  profileImageUrl: nil, email: "joker@gmail.com"),
        .init(id: NSUUID().uuidString, username: "spiderman", fullname: "Peter Parker", bio: "ironman bio",  profileImageUrl: nil, email: "spiderman@gmail.com"),
        .init(id: NSUUID().uuidString, username: "venom", fullname: "Eddie Brock", bio: "ironman bio", profileImageUrl: nil, email: "venom@gmail.com"),
    ]
}
