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
    
    static let shared = AuthService()
    
    // 로그인한 사용자를 현재 사용자로 초기화
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    @MainActor
    func logIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user  // => 현재 사용자가 로그인한 사용자가 되도록
        } catch {
            print("DEBUG: Failed to login user \(error.localizedDescription)")
        }

    }
    
    @MainActor
    func createUser(email: String, password: String, username: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user  // => 현재 사용자가 새로생성한 사용자가 되도록
            print("DEBUG: Create user..")
            await uploadUserData(uid: result.user.uid, username: username, email: email)
            print("DEBUG: Upload user data..")
        } catch {
            print("DEBUG: Failed to register user \(error.localizedDescription)")
        }
    }
    
    func loadUserData() async throws {
        
    }
    
    // 로그아웃은 에러가 발생할 일이 없으므로 async throws 사용을 안하는 것인가??
    func signOut() {
        try? Auth.auth().signOut()
        self.userSession = nil  // 로그아웃을 했으므로 로그인한 사용자가 없는 것
    }
    
    // user에 대한 데이터를 DB에 저장하기 위해
    // => input 파라미터: user에 대해서 꼭 필요한 데이터 (fullname, profileImageUrl은 옵셔널 이므로 필요 x)
    private func uploadUserData(uid: String, username: String, email: String) async {
        let user = User(id: uid, username: username, email: email)
        // user에 대한 데이터를 저장해야 되는데 바로 넣을수 없고 인코딩하여 그 인코딩한 데이터를 업로드 해야 된다.
        guard let encodeUser = try? Firestore.Encoder().encode(user) else { return }
        
        try? await Firestore.firestore().collection("users").document(user.id).setData(encodeUser)
    }
}



