//
//  ProfileCellView.swift
//  Instagram15.4
//
//  Created by 승찬 on 2023/06/01.
//

import SwiftUI

struct ProfileCellView: View {
    
    var posts: [Post]
    
    let imageDimension: CGFloat = (UIScreen.main.bounds.width / 3) - 1
       
    var gridItem: [GridItem] = [
        GridItem(.flexible(), spacing: 1),  // 여기서 spacing은 item간의 spacing
        GridItem(.flexible(), spacing: 1),
        GridItem(.flexible(), spacing: 1),
    ]

    var body: some View {
        // 포스트
        LazyVGrid(columns: gridItem, spacing: 1) {  // Grid안에 있는 spacing은 lineSpacing
            ForEach(posts) { post in
                Image(post.imageUrl)
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageDimension, height: imageDimension)
                    .clipped()
            }
        }   // VGrid

    }
}

struct ProfileCellView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCellView(posts: Post.MOCK_POSTS)
    }
}
