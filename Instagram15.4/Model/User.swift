//
//  User.swift
//  Instagram15.4
//
//  Created by 승찬 on 2023/06/01.
//

import Foundation

struct User: Identifiable, Hashable, Codable {
    let id: String
    var username: String
    var fullname: String?
    var profileImageUrl: String?
    let email: String
}

// 아이언맨, 그루트, 조커, 스파이터맨, 베놈

extension User {
    static var MOCK_USERS: [User] = [
        .init(id: NSUUID().uuidString, username: "ironman", fullname: "Tony Stark", profileImageUrl: "ironman", email: "ironman@gmail.com"),
        .init(id: NSUUID().uuidString, username: "groot", fullname: nil, profileImageUrl: "groot", email: "groot@gmail.com"),
        .init(id: NSUUID().uuidString, username: "joker", fullname: "Heath Ledger", profileImageUrl: "joker", email: "joker@gmail.com"),
        .init(id: NSUUID().uuidString, username: "spiderman", fullname: "Peter Parker", profileImageUrl: "spiderman", email: "spiderman@gmail.com"),
        .init(id: NSUUID().uuidString, username: "venom", fullname: "Eddie Brock", profileImageUrl: "venom-7", email: "venom@gmail.com"),
    ]
}
