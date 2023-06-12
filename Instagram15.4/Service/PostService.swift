//
//  PostService.swift
//  Instagram15.4
//
//  Created by 승찬 on 2023/06/07.
//

import Foundation
import Firebase

struct PostService {
    
    // Feed에 모든 포스트를 나타내는 함수
    static func fetchFeedPosts() async throws -> [Post] {
//        var posts = [Post]()
        
        // posts에 대한 모든 snapshot 데이터
        let snapshot = try await COLLECTION_POSTS.getDocuments()
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
        
        posts.sort(by: { $0.timestamp.seconds > $1.timestamp.seconds })
//        // 포스트에 유저에 대한 정보를 나타내기 위해
//        for post in posts {
//            let ownerUid = post.ownerUid
//            // uid를 통해서 유저에 대한 정보를 불러와야 된다
//            let postUser = try await UserService.fetchUser(withUid: ownerUid)
//            post.user = postUser
//        }
        
        // => post가 let이므로 아래와 같이 변경 => 데이터만 필요하므로 인덱스로 접근  => ??????
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
    
    // 각 user에 맞는 포스트를 프로필에 나타내는 함수
    static func fetchUserPosts(uid: String) async throws -> [Post] {
        // post의 owneruid를 통해 각 유저에 맞는 포스트를 필터링 하여 표현
        let snapshot = try await COLLECTION_POSTS.whereField("ownerUid", isEqualTo: uid).getDocuments()
        var posts = try snapshot.documents.compactMap({ try $0.data(as: Post.self) })
        posts.sort(by: { $0.timestamp.seconds > $1.timestamp.seconds })
        return posts
    }
}
