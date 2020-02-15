//
//  User.swift
//  travlr
//
//  Created by Razvan-Antonio Berbece on 15/02/2020.
//  Copyright © 2020 Razvan-Antonio Berbece. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase

struct UserStruct {
    var email: String
    var displayName: String
    var photoURL: URL
    
    init(user: User) {
        self.email = user.email ?? "default"
        self.displayName = user.displayName ?? "default"
        self.photoURL = user.photoURL ?? URL(string: "default")!
    }
}
