//
//  UploadPostViewModel.swift
//  Instagram15.4
//
//  Created by 승찬 on 2023/06/03.
//

import Foundation
import SwiftUI

class UploadPostViewModel: ObservableObject {
    @Published var selectedImage: UIImage? {
        didSet { Task { await uploadImage(forItem: selectedImage)} }
    }
    
    @Published var postImage: Image?
    
    // => 내가 선택한 이미지가 나오기 위해 그 이미지에 대한 데이터가 필요하므로 viewModel을 통해 이미지에 대한 데이터를 가져오고 그 데이터를 view에 다가 설정
    func uploadImage(forItem item: UIImage?) async {
        
        //  item -> 그 item에 대한 image data -> 받은 image data 를 uiimage로 바꾸고 -> post image에 설정
        guard let item = item else { return }
        
        if let imageData = item.pngData() {     // item에 대한 image data
            // imageData를 사용하여 필요한 업로드 작업을 수행합니다.
            guard let uiImage = UIImage(data: imageData) else { return }
            self.postImage = Image(uiImage: uiImage)    // => uiimage에 데이터를 받아서 image로 변환
        }
    }
}
