//
//  storageHandler.swift
//  travlr
//
//  Created by Razvan-Antonio Berbece on 11/02/2020.
//  Copyright © 2020 Razvan-Antonio Berbece. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage
import SwiftUI

class storageHandler {
    
    var storageRef: StorageReference? = nil
    var picURL: String = ""
    
    func uploadProfileImage(_ image: UIImage, completion: @escaping ((_ url: URL?)->())) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let user = Auth.auth().currentUser
        let storageRef = Storage.storage().reference().child("user/\(uid)")
        
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        storageRef.putData(imageData, metadata: metaData) { metaData, error in
            if error == nil, metaData != nil {
                
                storageRef.downloadURL { url, error in
                    completion(url)
                    // success!
                }
            } else {
                // failed
                completion(nil)
            }
        }
    }
    
    // func changeProfileImage()
    
}
