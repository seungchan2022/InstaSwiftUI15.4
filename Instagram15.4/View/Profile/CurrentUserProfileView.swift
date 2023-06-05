//
//  CurrentUserProfileView.swift
//  Instagram15.4
//
//  Created by 승찬 on 2023/06/01.
//

import SwiftUI

// 현재 유저의 프로필 view

struct CurrentUserProfileView: View {
    
    let user: User
    
    var posts: [Post] {
        return Post.MOCK_POSTS.filter({ $0.user?.username == user.username })
    }
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack {
                    ProfileHeaderVIew(user: user)
                    
                    Divider()
                        .background(.black)
                    
                    ProfileCellView(posts: posts)
                    
                }   // VStack (전체 view)
                .padding(.top, 10)  // Navigation bar와 살짝 떨어지도록
            }   // ScrollView
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        AuthService.shared.signOut()
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(Color.black)
                    }
                }
            }   // toolbar
        }   // NavigationView
    }
}

struct CurrentUserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentUserProfileView(user: User.MOCK_USERS[4])
    }
}
