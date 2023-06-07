//
//  Post.swift
//  Instagram15.4
//
//  Created by 승찬 on 2023/06/01.
//

import Foundation
import SwiftUI
import Firebase

struct Post: Identifiable, Hashable, Codable {
    let id: String  // post id
    let ownerUid: String
    let caption: String
    var likes: Int
    let imageUrl: String   // post image
    let timestamp: Timestamp
    var user: User?     // 유저에 대한 데이터는 이렇게 불러온다 => 불러올 유저 데이터: 프로필이미지, 유저 이름
}

// 아이언맨, 그루트, 조커, 스파이터맨, 베놈

extension Post {
    static var MOCK_POSTS: [Post] = [
        .init(id: NSUUID().uuidString,
              ownerUid: NSUUID().uuidString,
              caption: "I'm ironman",
              likes: 32,
              imageUrl: "ironman",
              timestamp: Timestamp(),
              user: User.MOCK_USERS[0]
             ),
        .init(id: NSUUID().uuidString,
              ownerUid: NSUUID().uuidString,
              caption: "I'm groot",
              likes: 9,
              imageUrl: "groot",
              timestamp: Timestamp(),
              user: User.MOCK_USERS[1]
             ),
        .init(id: NSUUID().uuidString,
              ownerUid: NSUUID().uuidString,
              caption: "Why so serious ~",
              likes: 25,
              imageUrl: "joker",
              timestamp: Timestamp(),
              user: User.MOCK_USERS[2]
             ),
        .init(id: NSUUID().uuidString,
              ownerUid: NSUUID().uuidString,
              caption: "This is a some caption text or now this is a some caption his is a some caption text or now this is a some caption..",
              likes: 12,
              imageUrl: "spiderman",
              timestamp: Timestamp(),
              user: User.MOCK_USERS[3]
             ),
        .init(id: NSUUID().uuidString,
              ownerUid: NSUUID().uuidString,
              caption: "This is a some caption text or now this is a some caption.This is a some caption text or now this is a some caption.",
              likes: 4,
              imageUrl: "venom-7",
              timestamp: Timestamp(),
              user: User.MOCK_USERS[4]
             ),
        .init(id: NSUUID().uuidString,
              ownerUid: NSUUID().uuidString,
              caption: "This is a some caption text or now this is a some caption.",
              likes: 7,
              imageUrl: "venom",
              timestamp: Timestamp(),
              user: User.MOCK_USERS[4]
             ),
    ]
}
