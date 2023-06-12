//
//  UploadPostView.swift
//  Instagram15.4
//
//  Created by 승찬 on 2023/06/03.
//

import SwiftUI

struct UploadPostView: View {
    
    //    @State private var caption: String = ""
    @State private var showingImagePicker: Bool = false
    //    @State private var inputImage: UIImage?
    @StateObject private var viewModel = UploadPostViewModel()
    @State private var isUploading = false
    
    @Binding var tabIndex: Int
    
    func clearCaption() {
        viewModel.caption = ""
    }
    
    var body: some View {
        ZStack {
            VStack {
                
                HStack {    // Action buttons
                    Button {
                        // cancel 버튼을 누르면 feed view가 나오도록 => index 이용
                        viewModel.caption = ""
                        viewModel.selectedImage = nil
                        viewModel.postImage = nil
                        tabIndex = 0
                    } label: {
                        Text("Cancel")
                    }
                    
                    Spacer()
                    
                    Text("New Post")
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Button {
                        Task {
                            isUploading = true
                            try await viewModel.uploadPost(caption: viewModel.caption)
                            viewModel.caption = ""
                            viewModel.selectedImage = nil
                            viewModel.postImage = nil
                            tabIndex = 0
                            isUploading = false
                        }
                    } label: {
                        Text("Upload")
                    }
                    .disabled(isUploading)
                    
                }   // HStack
                .font(.subheadline)
                .padding(.horizontal)
                
                HStack {    // postImage, text
                    Group {
                        if let image = viewModel.postImage {
                            image
                                .resizable()
                                .frame(width: 100, height: 100)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray, lineWidth: 0.5)
                                )
                        } else {
                            Image(systemName: "photo")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .cornerRadius(10)
                                .foregroundColor(Color(.systemGray))
                        }
                    }
                    .onTapGesture {
                        showingImagePicker.toggle()
                    }
                    .sheet(isPresented: $showingImagePicker) {
                        ImagePicker(image: $viewModel.selectedImage)
                    }
                    
                    Spacer()
                    
                    TextEditor(text: $viewModel.caption)
                        .autocorrectionDisabled()
                        .frame(width: 250, height: 100)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 2)
                        )
                }   // HSatack
                .padding(.horizontal)
                
                // clear button
                HStack {
                    Text("If you want to delete all texts, click this  ")
                    
                    Button {
                        clearCaption()
                    } label: {
                        Image(systemName: "xmark.app")
                            .imageScale(.large)
                            .foregroundColor(Color(.systemRed))
                    }
                }
                .padding(.top, 10)
                
                Spacer()
                
            }   // VStack (전체 view)
            .onAppear {
                showingImagePicker.toggle()
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $viewModel.selectedImage)
            }
            
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

struct UploadPostView_Previews: PreviewProvider {
    static var previews: some View {
        UploadPostView(tabIndex: .constant(0))
    }
}
