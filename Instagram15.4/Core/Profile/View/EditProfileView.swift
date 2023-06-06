//
//  EditProfileView.swift
//  Instagram15.4
//
//  Created by 승찬 on 2023/06/06.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var showingImagePicker = false
    @StateObject var viewModel: EditProfileViewModel
    
    // 어딘가에서 사용자를 가져와야 하므로 초기화 해야 된다
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: EditProfileViewModel(user: user))
    }
    
    var body: some View {
        VStack {
            
            HStack {
                // toolbar
                Button("Cancel") {
                    dismiss()
                }
                
                Spacer()
                
                Text("Edit Profile")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button {
                    Task { try await viewModel.uplaodUserData() }
                } label: {
                    Text("Done")
                        .font(.subheadline)
                        .fontWeight(.bold)
                }
            }   // HStack
            .padding(.horizontal)
            
            Divider()
            
            VStack(spacing: 10) {
                // image, text
                
                Group {
                    if let image = viewModel.profileImage {
                        image
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    }
                }
                .onTapGesture {
                    showingImagePicker.toggle()
                }
                .sheet(isPresented: $showingImagePicker) {
                    ImagePicker(image: $viewModel.selectedImage)
                }
                
                Text("Edit profile picture")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(.systemBlue))
                
                Divider()
            }
            .padding(.vertical)
            
            // fullname, username
            VStack {
                EditProfileRowView(title: "Name", placeholder: "Enter your fullname..", text: $viewModel.fullname)
                
                EditProfileRowView(title: "Bio", placeholder: "Enter your bio..", text: $viewModel.bio)
            }
            .padding()
            
            Spacer()
        }   // view
    }
}

struct EditProfileRowView: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        
        HStack {
            Text(title)
                .padding(.leading, 8)
                .frame(width: 100, alignment: .leading)
            
            VStack {
                TextField(placeholder, text: $text)
                    .autocorrectionDisabled()
                
                Divider()
            }
        }
        .font(.subheadline)
        .frame(height: 36)
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(user: User.MOCK_USERS[0])
    }
}
