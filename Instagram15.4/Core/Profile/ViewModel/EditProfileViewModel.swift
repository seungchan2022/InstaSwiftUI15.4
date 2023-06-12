//
//  EditProfileViewModel.swift
//  Instagram15.4
//
//  Created by 승찬 on 2023/06/06.
//

import Foundation
import SwiftUI
import Firebase

class EditProfileViewModel: ObservableObject {
    @Published var user: User
    
    @Published var selectedImage: UIImage? {
        didSet { Task { await uploadImage(forItem: selectedImage)} }
    }
    
    @Published var profileImage: Image?
    @Published var fullname = ""
    @Published var bio = ""
    
    // Image를 바로 사용할 수 없으므로 UIImage를 받아서 사용하거나, 변환 해준다.
    private var uiImage: UIImage?
    
    // 이러한 업데이트 옵션을 성공적으로 실행하려면 사용자에 대한 몇 가지 사항을 알아야 하기 때문에 사용자에 대해 초기화
    init(user: User) {
        self.user = user
        
        if let fullname = user.fullname {
            self.fullname = fullname
        }
        
        if let bio = user.bio  {
            self.bio = bio
        }
    }
    
    // => 내가 선택한 이미지가 나오기 위해 그 이미지에 대한 데이터가 필요하므로 viewModel을 통해 이미지에 대한 데이터를 가져오고 그 데이터를 view에 다가 설정
    func uploadImage(forItem item: UIImage?) async {
        //  item -> 그 item에 대한 image data -> 받은 image data 를 uiimage로 바꾸고 -> profile image에 설정
        guard let item = item else { return }
        
        if let imageData = item.pngData() {     // item에 대한 image data
            // imageData를 사용하여 필요한 업로드 작업을 수행합니다.
            guard let uiImage = UIImage(data: imageData) else { return }
            self.uiImage = uiImage
            self.profileImage = Image(uiImage: uiImage)    // => uiimage에 데이터를 받아서 image로 변환
        }
    }
    
    // 이렇게 하는 이유는 이러한 값만 업데이트하는 것이 더 효율적이기 때문이다.
    // 속성이 변경되면 사용자가 완료를 누를 때마다 API 호출이나 변경되지 않은 정보를 데이터베이스에 업로드하려고하면, 매우 비효율적이며 바람직하지 않다.
    func uplaodUserData() async throws {
        // dictionary를 이용하여 데이터를 따로 인코딩할 필요 없도록 한다.
        var data = [String: Any]()
        
        // update profile image if changed
        // => Image를 바로 사용할 수 없으므로 UIImage를 받아서 사용하거나, 변환 해준다.
        if let uiImage = uiImage {
            let imageUrl = try await ImageUploader.uploadImage(image: uiImage)
            data["profileImageUrl"] = imageUrl
        }
        
        // update fullname if changed
        // 어떻게 업데이트가 되는지 => 지금 작성하는 것이 비어있지 않고, 이전과 작성한 것과 다르면 => 변경된것 ?
        if !fullname.isEmpty && user.fullname != fullname {
            data["fullname"] = fullname
        }
        
        // update bio if changed
        if !bio.isEmpty && user.bio != bio {
            data["bio"] = bio
        }
        
        // 데이터가 하나라도 바뀌면 업데이트
        if !data.isEmpty {
            try await COLLECTION_USERS.document(user.id).updateData(data)
        }
    }
}
