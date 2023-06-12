//
//  Constants.swift
//  Instagram15.4
//
//  Created by 승찬 on 2023/06/12.
//

import Firebase

let COLLECTION_USERS = Firestore.firestore().collection("users")

let COLLECTION_FOLLOWERS = Firestore.firestore().collection("followers")
let COLLECTION_FOLLOWING = Firestore.firestore().collection("following")

let COLLECTION_POSTS = Firestore.firestore().collection("posts")

let COLLECTION_NOTIFICATIONS = Firestore.firestore().collection("notifications")
