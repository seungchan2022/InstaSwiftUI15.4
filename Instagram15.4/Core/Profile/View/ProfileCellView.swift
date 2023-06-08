//
//  ProfileCellView.swift
//  Instagram15.4
//
//  Created by 승찬 on 2023/06/01.
//

import SwiftUI
import Kingfisher

struct ProfileCellView: View {
    
    @StateObject var viewModel: ProfileCellViewModel
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: ProfileCellViewModel(user: user))
    }
    
    let imageDimension: CGFloat = (UIScreen.main.bounds.width / 3) - 1
       
    var gridItem: [GridItem] = [
        GridItem(.flexible(), spacing: 1),  // 여기서 spacing은 item간의 spacing
        GridItem(.flexible(), spacing: 1),
        GridItem(.flexible(), spacing: 1),
    ]

    var body: some View {
        // 포스트
        LazyVGrid(columns: gridItem, spacing: 1) {  // Grid안에 있는 spacing은 lineSpacing
            ForEach(viewModel.posts) { post in
                KFImage(URL(string: post.imageUrl))
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
        ProfileCellView(user: User.MOCK_USERS[0])
    }
}
