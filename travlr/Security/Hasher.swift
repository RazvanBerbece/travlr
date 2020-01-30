//
//  Hasher.swift
//  travlr
//
//  Created by Razvan-Antonio Berbece on 30/01/2020.
//  Copyright © 2020 Razvan-Antonio Berbece. All rights reserved.
//

import Foundation
import CryptoSwift

class Hasher {
    
    private let salt = "dg27263r2c1oic2-||=qc//c.auwyt@@??@@}@@"
    
    func passwordHash(password: String) -> String {
        return "\(password).\(self.salt)".sha256()
    }
    
}
