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

class StorageHandler {
    
    private let user = Auth.auth().currentUser
    private var settings = WatchedVariables()
    
    func uploadProfileImage(_ image: UIImage) {
        guard let uid = self.user?.uid else { return }
        let storageRef = Storage.storage().reference().child("user/\(uid)")
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        storageRef.putData(imageData, metadata: metaData) { metaData, error in
            if error == nil, metaData != nil {
                storageRef.downloadURL { url, error in
                    if error != nil, url != nil {
                        let changeRequest = self.user!.createProfileChangeRequest()
                        changeRequest.photoURL = url
                        changeRequest.commitChanges {
                            (error) in
                            if error != nil {
                                print(error)
                            }
                            else {
                                print("Successfully updated profile data ! \(url)")
                            }
                        }
                    }
                }
            }
            else {
                // failed upload
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.settings.image = UIImage(data: data)
            }
        }
    }
}
