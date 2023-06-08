//
//  ProfileView.swift
//  Instagram15.4
//
//  Created by 승찬 on 2023/05/30.
//

import SwiftUI

// SearchView에서 눌렀을때 들어가는 유저의 프로필 view

struct ProfileView: View {
    
    let user: User
        
    var body: some View {
        
        ScrollView {
            VStack {
                Spacer()
                Spacer()
                Spacer()
                
                ProfileHeaderVIew(user: user)
                
                Divider()
                    .background(.black)
                
                ProfileCellView(user: user)
                
            }   // VStack (전체 view)
            .padding(.top, 10)  // Navigation bar와 살짝 떨어지도록
        }   // ScrollView
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User.MOCK_USERS[4])
    }
}
