//
//  SearchView.swift
//  Instagram15.4
//
//  Created by 승찬 on 2023/05/30.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var selectedUser: User? = nil
    @StateObject var viewModel = SearchViewModel()
    
    // 기본으로 설정되어있는 네비게이션의 backButton 말고 커스텀 하려 사용하기 위해
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            List(viewModel.users) { user in
                
                // 선택했을때 해당 유저의 프로필로 들어가도록
                // => user에 대한 데이터가 들어가야된다
                Button(action: { selectedUser = user }) {
                    HStack {
                        CircleProfileImage(user: user, size: .xSmall)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(user.username)
                                .fontWeight(.semibold)
                            
                            // fullname은 옵셔널이므로 있으면 보이도록 설정
                            if let fullname = user.fullname {
                                Text(fullname)
                            }
                        }
                        .font(.footnote)
                        
                        Spacer()
                    }   // HStack
                }
                .padding(.horizontal)
                .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                
            }   // List
            .listStyle(.plain)
            // displayMode를 설정하지 않으면 화면을 아래로 끌어내려야 search bar가 보인다
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search..")
            
            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.top, 10)
            
            .fullScreenCover(item: $selectedUser) { user in
                ProfileView(user: user)
//                    .navigationBarBackButtonHidden(true)
            }
        }   // NavigationView
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
