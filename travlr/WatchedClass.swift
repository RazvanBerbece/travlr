//
//  WatchedClass.swift
//  travlr
//
//  Created by Razvan-Antonio Berbece on 02/02/2020.
//  Copyright © 2020 Razvan-Antonio Berbece. All rights reserved.
//

import Foundation
import UIKit

class WatchedVariables: ObservableObject {
    @Published var exitLoginView: Bool = false
    
    @Published var user_data: [String] = []
    @Published var image: UIImage? = nil
    
    @Published var hasLoggedIn: Bool = false
    @Published var editSettings: Bool = false
}
