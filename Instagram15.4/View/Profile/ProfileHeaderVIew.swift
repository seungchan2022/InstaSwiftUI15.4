//
//  ProfileHeaderVIew.swift
//  Instagram15.4
//
//  Created by 승찬 on 2023/06/01.
//

import SwiftUI

struct ProfileHeaderVIew: View {
    
    let user: User
    
    var body: some View {
        VStack(spacing: 10) {    // 헤더뷰
            
            HStack {    // profileImage, userstats
                Image(user.profileImageUrl ?? "")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 64, height: 64)
                    .clipShape(Circle())
                
                Spacer()
                
                HStack {
                    VStack(alignment: .center) {
                        Text("3")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        Text("posts")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    
                    VStack(alignment: .center) {
                        Text("3")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        Text("followers")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    
                    VStack(alignment: .center) {
                        Text("3")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        Text("following")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    
                }   // Hstack (UserStats)
                .background(
                    RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.5), lineWidth: 2)
                )
                .padding(.trailing)
                
            }   // Hstack
            .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 5) {    // fullname, username
                if let fullname = user.fullname {
                    Text(fullname)
                        .fontWeight(.semibold)
                }
                
                Text(user.username)
                
            }   // VStack
            .font(.footnote)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.top, 5)
            
            // Action button
            
            Button {
                print("DEBUG: Did tap edit profile button..")
            } label: {
                Text("Edit Profile")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .frame(width: 320, height: 32)
                    .foregroundColor(.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.5), lineWidth: 2)
                    )
            }
            .padding(.top, 5)
        }   // VStack (헤더뷰)
        
    }
}

struct ProfileHeaderVIew_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderVIew(user: User.MOCK_USERS[0])
    }
}
