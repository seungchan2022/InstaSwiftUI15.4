//
//  MainTabView.swift
//  Instagram15.4
//
//  Created by 승찬 on 2023/05/30.
//

import SwiftUI

struct MainTabView: View {
    
    @State private var selection = 0

    var body: some View {
        TabView(selection: $selection) {
            
            FeedView()
                .tabItem {
                    selection == 0 ? Image("home_selected") : Image("home_unselected")
                }
                .tag(0)
            
            SearchView()
                .tabItem {
                    selection == 1 ? Image("search_selected") : Image( "search_unselected")
                }
                .tag(1)
            
            // UploadPostView에 tabIndex가 있으므로 tabIndex에 다가 selection을 넣는 느낌
            UploadPostView(tabIndex: $selection)
                .tabItem {
                    selection == 2 ? Image("plus_unselected") : Image("plus_unselected")
                }
                .tag(2)
            
            
            Text("Feed")
                .tabItem {
                    selection == 3 ? Image("like_selected") : Image("like_unselected")
                }
                .tag(3)
            
            CurrentUserProfileView(user: User.MOCK_USERS[4])
                .tabItem {
                    selection == 4 ? Image("profile_selected") : Image( "profile_unselected")
                }
                .tag(4)
        }
        
        // UITabBar의 배경색 넣기
        .onAppear() {
            UITabBar.appearance().backgroundColor = .gray.withAlphaComponent(0.1)
        }
        
        // tabItem의 tintColor
        .accentColor(.black)
    }
}


struct MainTab_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}


