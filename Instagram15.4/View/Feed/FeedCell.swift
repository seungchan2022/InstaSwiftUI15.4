//
//  FeedCell.swift
//  Instagram15.4
//
//  Created by 승찬 on 2023/05/30.
//

import SwiftUI

struct FeedCell: View {
    
    let post: Post
    
    var body: some View {
        VStack {
            HStack {    // profileImage, username
                Image(post.user?.profileImageUrl ?? "")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())
                
                Button {
                    print("DEBUG: Did tap user name button..")
                } label: {
                    Text(post.user?.username ?? "")
                        .font(.headline)
                        .foregroundColor(.black)
                }
                
                Spacer()
            }
            .padding(.horizontal, 8)
            
            // postImage
            Image(post.imageUrl)
                .resizable()
                .scaledToFill()
                .frame(height: 400)
                .clipShape(Rectangle())
            
            HStack {    // Action Buttons
                
                Button {
                    print("DEBUG: Did tap like button..")
                } label: {
                    Image(systemName: "heart")
                        .imageScale(.large)
                }
                
                Button {
                    print("DEBUG: Did tap like button..")
                } label: {
                    Image(systemName: "bubble.right")
                        .imageScale(.large)
                }
                
                Button {
                    print("DEBUG: Did tap like button..")
                } label: {
                    Image(systemName: "paperplane")
                        .imageScale(.large)
                }
                
                Spacer()
                
            }   // HStack (Action Buttons)
            .padding(.top, 3)
            .padding(.horizontal, 8)
            .foregroundColor(.black)
            .brightness(0.3)    // 밝기
            
            VStack(spacing: 5) {    // Texts
                HStack {
                    Text("\(post.likes) likes")
                        .fontWeight(.semibold)
                    
                    Spacer()
                }
                
                HStack {
                    Text("\(post.user?.username ?? "")  ")
                        .fontWeight(.semibold) +
                    Text(post.caption)
                    
                    Spacer()
                }
                
                HStack {
                    Text("2 weeks")
                        .foregroundColor(.gray)
                    
                    Spacer()
                }
                
            }   // VStack (Texts)
            .font(.footnote)
            .padding(.top, 3)
            .padding(.horizontal, 8)
            
        }   // VStack (전체 view)
    }
}

struct FeedCell_Previews: PreviewProvider {
    static var previews: some View {
        FeedCell(post: Post.MOCK_POSTS[5])
    }
}
