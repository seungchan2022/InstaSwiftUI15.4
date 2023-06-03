//
//  UploadPostView.swift
//  Instagram15.4
//
//  Created by 승찬 on 2023/06/03.
//

import SwiftUI

struct UploadPostView: View {
    
    @State private var caption: String = ""
    @State private var showingImagePicker: Bool = false
//    @State private var inputImage: UIImage?
    @StateObject private var viewModel = UploadPostViewModel()
    
    @Binding var tabIndex: Int
    
    var body: some View {
        VStack {
            
            HStack {    // Action buttons
                Button {
                    // cancel 버튼을 누르면 feed view가 나오도록 => index 이용
                    caption = ""
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
                    print("DEBUG: Handle Upload")
                } label: {
                    Text("Upload")
                }
            }   // HStack
            .font(.subheadline)
            .padding(.horizontal)
            
            HStack {    // postImage, text
                if let image = viewModel.postImage {
                    image
                        .resizable()
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                }
                
                Spacer()
                
                TextEditor(text: $caption)
                    .frame(width: 250, height: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 2)
                    )
            }   // HSatack
            .padding(.horizontal)
            
            Spacer()
            
        }   // VStack (전체 view)
        .onAppear {
            showingImagePicker.toggle()
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $viewModel.selectedImage, tabIndex: $tabIndex)
        }
    }
}

struct UploadPostView_Previews: PreviewProvider {
    static var previews: some View {
        UploadPostView(tabIndex: .constant(0))
    }
}
