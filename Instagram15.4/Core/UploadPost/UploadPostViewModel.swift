//
//  UploadPostViewModel.swift
//  Instagram15.4
//
//  Created by 승찬 on 2023/06/03.
//

import Foundation
import SwiftUI
import Firebase

class UploadPostViewModel: ObservableObject {
    @Published var caption: String = ""
    
    @Published var selectedImage: UIImage? {
        didSet { Task { await uploadImage(forItem: selectedImage)} }
    }
    
    @Published var postImage: Image?
    
    // Image를 바로 사용할 수 없으므로 UIImage를 받아서 사용하거나, 변환 해준다.
    private var uiImage: UIImage?
    
    // => 내가 선택한 이미지가 나오기 위해 그 이미지에 대한 데이터가 필요하므로 viewModel을 통해 이미지에 대한 데이터를 가져오고 그 데이터를 view에 다가 설정
    func uploadImage(forItem item: UIImage?) async {
        
        //  item -> 그 item에 대한 image data -> 받은 image data 를 uiimage로 바꾸고 -> post image에 설정
        guard let item = item else { return }
        
        if let imageData = item.pngData() {     // item에 대한 image data
            // imageData를 사용하여 필요한 업로드 작업을 수행합니다.
            guard let uiImage = UIImage(data: imageData) else { return }
            self.uiImage = uiImage
            self.postImage = Image(uiImage: uiImage)    // => uiimage에 데이터를 받아서 image로 변환
        }
    }
    
    func uploadPost(caption: String) async throws {
        // 게시물을 업로드하기 전에는 누가 업로드 하는지와 이미지가 있는지 확인해야 한다..
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let uiImage = uiImage else { return }
        
        // post에 대한 document를 만들면 자동으로 id가 생성된다
        let postRef = COLLECTION_POSTS.document()
        //  게시물을 업로드하기전 이미지를 업로드하고 => post에 대한 원시값을 가지고 => 원시값을 인코딩 하여 => 인코딩된 데이터를 세팅한다
        guard let imageUrl = try await ImageUploader.uploadImage(image: uiImage) else { return }
        let post = Post(id: postRef.documentID, ownerUid: uid, caption: caption, likes: 0, imageUrl: imageUrl, timestamp: Timestamp())
        guard let encodePost = try? Firestore.Encoder().encode(post) else { return }
        
        // 원시값이 아닌 인코딩된 값을 넣어주어야 한다!!!
        try await postRef.setData(encodePost)
    }
}
