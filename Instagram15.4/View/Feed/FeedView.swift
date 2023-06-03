//
//  FeedView.swift
//  Instagram15.4
//
//  Created by 승찬 on 2023/05/30.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(Post.MOCK_POSTS) { post in
                        FeedCell(post: post)
                    }
                    .padding(.bottom, 20)   // 포스트가 끝나고 다음 포스트와의 간격
                }   // LazyVStack
                .padding(.top, 10)  // Navigation bar와 살짝 떨어지도록
            }   // ScrollView
            .navigationTitle("Feed")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("Instagram_logo_white")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 32)
                        .foregroundColor(Color.black)
                }
            }   // left bar item
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "paperplane")
                        .imageScale(.large)
                        .brightness(-1)
                }
            }   // right bar item
            
        }   // NavigationView
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
