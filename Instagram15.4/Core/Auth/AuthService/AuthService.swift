//
//  AuthService.swift
//  Instagram15.4
//
//  Created by 승찬 on 2023/06/05.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestoreSwift

// authservice가 퍼블리셔이고 contenviewmodel이 서브스크라이버로 contentViewModel이 authservice에게 usersession에 대한 데이터를 요청하면서 combine을 사용하여 구독하는 그림
class AuthService {
    
    // 로그인한 사용자가 있는지 확인하기 위해 => 앱을 열때마다 로그인이 되어있는지 알야야 되기 때문에
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    static let shared = AuthService()
    
    // 로그인한 사용자를 현재 사용자로 초기화
    init()  {
        self.userSession = Auth.auth().currentUser
        // => 로그인한 유저를 현재 유저로 초기화한 바로 다음 현재 로그인한 유저의 데이터를 가져온다.
        Task { try await loadUserData() }
    }
    
    @MainActor
    func logIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user  // => 현재 사용자가 로그인한 사용자가 되도록
            try await loadUserData()
        } catch {
            print("DEBUG: Failed to login user \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func createUser(email: String, password: String, username: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user  // => 현재 사용자가 새로생성한 사용자가 되도록
            await uploadUserData(uid: result.user.uid, username: username, email: email)
        } catch {
            print("DEBUG: Failed to register user \(error.localizedDescription)")
        }
    }
    
    // 현재 로그인한 유저의 데이터를 가져오기 위해
    // => DB에 액세스 하기 위해서는 액세스할 수 있는 식별자가 필요한데 현재 로그인한 유저의 id를 사용
    @MainActor
    func loadUserData() async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
//        let snapshot = try await Firestore.firestore().collection("users").document(currentUid).getDocument()
//        // => snapshot을 통해서 현재 유저에 대한 데이터가 나오는데 그것을 @Published로 설정
//        self.currentUser = try? snapshot.data(as: User.self)    // 디코딩
        // UserService에서 uid를 통해 user의 데이터를 얻는 함수 구현
        self.currentUser = try await UserService.fetchUser(withUid: currentUid)
    }
    
    // 로그아웃은 에러가 발생할 일이 없으므로 async throws 사용을 안하는 것인가??
    func signOut() {
        try? Auth.auth().signOut()
        self.userSession = nil  // 로그아웃을 했으므로 로그인한 사용자가 없는 것
        self.currentUser = nil
    }
    
    // user에 대한 데이터를 DB에 저장하기 위해
    // => input 파라미터: user에 대해서 꼭 필요한 데이터 (fullname, profileImageUrl은 옵셔널 이므로 필요 x)
    private func uploadUserData(uid: String, username: String, email: String) async {
        let user = User(id: uid, username: username, email: email)
        self.currentUser = user
        // user에 대한 데이터를 저장해야 되는데 바로 넣을수 없고 인코딩하여 그 인코딩한 데이터를 업로드 해야 된다.
        guard let encodeUser = try? Firestore.Encoder().encode(user) else { return }
        // 경로에 맞게 user id를 통해 유저에 대한 데이터 설정
        try? await Firestore.firestore().collection("users").document(user.id).setData(encodeUser)
    }
}
