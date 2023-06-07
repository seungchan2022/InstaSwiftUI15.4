//
//  PostService.swift
//  Instagram15.4
//
//  Created by 승찬 on 2023/06/07.
//

import Foundation
import Firebase

struct PostService {
    
    static func fetchPosts() async throws -> [Post] {
//        var posts = [Post]()
        
        // posts에 대한 모든 snapshot 데이터
        let snapshot = try await Firestore.firestore().collection("posts").getDocuments()
//        let documents = snapshot.documents
//
//        for doc in documents {
//            guard let post = try? doc.data(as: Post.self) else {
//                return posts
//            }
//            posts.append(post)
//        }
        
        // 이렇게 하면 위에거 생략 가능
        var posts = try snapshot.documents.compactMap({ try $0.data(as: Post.self) })
        
//        // 포스트에 유저에 대한 정보를 나타내기 위해
//        for post in posts {
//            let ownerUid = post.ownerUid
//            // uid를 통해서 유저에 대한 정보를 불러와야 된다
//            let postUser = try await UserService.fetchUser(withUid: ownerUid)
//            post.user = postUser
//        }
        
        // => post가 let이므로 아래와 같이 변경 => 데이터만 필요하므로 인덱스로 접근
        // 포스트에 유저에 대한 정보를 나타내기 위해
        for i in 0 ..< posts.count {
            let post = posts[i]
            let ownerUid = post.ownerUid
            // uid를 통해서 유저에 대한 정보를 불러와야 된다
            let postUser = try await UserService.fetchUser(withUid: ownerUid)
            posts[i].user = postUser
        }
        
        return posts
    }
}