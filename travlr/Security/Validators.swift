//
//  Validators.swift
//  travlr
//
//  Created by Razvan-Antonio Berbece on 30/01/2020.
//  Copyright © 2020 Razvan-Antonio Berbece. All rights reserved.
//

import Foundation

class Validation {
    
    func isValidMailInput(input: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: input)
    }
    
}
