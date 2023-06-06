//
//  ImageUploader.swift
//  Instagram15.4
//
//  Created by 승찬 on 2023/06/06.
//

import Foundation
import UIKit
import FirebaseStorage

struct ImageUploader {
    // Image를 바로 사용할 수 없으므로 UIImage를 받아서 사용하거나, 변환 해준다.
    static func uploadImage(image: UIImage) async throws -> String? {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return nil }
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        do {
            let _ = try await ref.putDataAsync(imageData)
            let url = try await ref.downloadURL()
            return url.absoluteString
        } catch {
            print("DEBUG: Failed to uplod image with error \(error.localizedDescription)")
            return nil
        }
    }
}

// 이미지 데이터 압축 => 이미지 데이터를 넣을 파일 이름 설정 =>  파일 경로 설정
// => async로 이미지 데이터 넣고 => 파일 경로의 다운로드 url을 받고 => 문자열로 반환
