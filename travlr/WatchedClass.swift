//
//  WatchedClass.swift
//  travlr
//
//  Created by Razvan-Antonio Berbece on 02/02/2020.
//  Copyright © 2020 Razvan-Antonio Berbece. All rights reserved.
//

import Foundation

class WatchedVariables: ObservableObject {
    @Published var exitLoginView: Bool = false
    @Published var user_data: [[String : Any]] = [["" : ""]]
    @Published var hasLoggedIn: Bool = false
}
