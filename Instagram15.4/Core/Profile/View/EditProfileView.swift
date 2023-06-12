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
    @State private var isUploading = false // 로딩 표시기를 위한 새로운 상태 변수
    
    // 어딘가에서 사용자를 가져와야 하므로 초기화 해야 된다
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: EditProfileViewModel(user: user))
    }
    
    var body: some View {
        ZStack {
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
                        Task {
                            isUploading = true // 로딩 표시기 시작
                            try await viewModel.uplaodUserData()
                            dismiss()
                            isUploading = false
                        }
                    } label: {
                        Text("Done")
                            .font(.subheadline)
                            .fontWeight(.bold)
                    }
                    .disabled(isUploading) // 업로드 중에 버튼 비활성화
                    
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
                                .overlay(
                                    Circle()
                                        .stroke(Color.gray, lineWidth: 0.5)
                                )
                        } else {
                            CircleProfileImage(user: viewModel.user, size: .large)
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
                    HStack() {
                        Text("Name")
                            .frame(width: 100, alignment: .leading)
                        
                        TextField("Enter your fullname", text: $viewModel.fullname)
                            .font(.subheadline)
                            .autocorrectionDisabled(true)
                            .autocapitalization(.none)
                    }
                    .padding(.horizontal)
                    
                    HStack() {
                        Text("Bio")
                            .frame(width: 100, alignment: .leading)
                        
                        TextField("Enter your Bio", text: $viewModel.bio)
                            .font(.subheadline)
                            .autocorrectionDisabled(true)
                            .autocapitalization(.none)
                    }
                    .padding(.horizontal)
                }
                .padding()
                
                Spacer()
                
            }   // VStack
            
            if isUploading { // 로딩 표시기 표시
                Rectangle()
                    .fill(Color.black.opacity(0.5))
                    .ignoresSafeArea()
                    .allowsHitTesting(true) // Prevent interaction with underlying views
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .frame(width: 80, height: 80)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding()
            }
        }   // ZStack
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(user: User.MOCK_USERS[0])
    }
}
