//
//  ProfileHeaderVIew.swift
//  Instagram15.4
//
//  Created by 승찬 on 2023/06/01.
//

import SwiftUI

struct ProfileHeaderVIew: View {
    
    @State private var showEditProfile = false
    
    let user: User
    
    var body: some View {
        VStack(spacing: 10) {    // 헤더뷰
            
            HStack {    // profileImage, userstats
                CircleProfileImage(user: user, size: .medium)
                
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
            
            VStack(alignment: .leading, spacing: 5) {    // fullname, bio
                if let fullname = user.fullname {
                    Text(fullname)
                        .fontWeight(.semibold)
                }
                
                if let bio = user.bio {
                    Text(bio)
                        .fontWeight(.semibold)
                }
                                
            }   // VStack
            .font(.footnote)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.top, 5)
            
            // Action button
            
            Button {
                if user.isCurrentUser {
                    showEditProfile.toggle()
                } else {
                    print("Follow user..")
                }
            } label: {
                Text(user.isCurrentUser ? "Edit Profile" : "Follow")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .frame(width: 320, height: 32)
                    .background(user.isCurrentUser ? .white : Color(.systemBlue))
                    .foregroundColor(user.isCurrentUser ? .black : .white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.5), lineWidth: 2)
                    )
            }
            .padding(.top, 5)
        }   // VStack (헤더뷰)
        .fullScreenCover(isPresented: $showEditProfile) {
            EditProfileView(user: user)
        }
        
    }
}

struct ProfileHeaderVIew_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderVIew(user: User.MOCK_USERS[0])
    }
}
