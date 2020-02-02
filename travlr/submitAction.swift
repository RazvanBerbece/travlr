//
//  submitAction.swift
//  travlr
//
//  Created by Razvan-Antonio Berbece on 30/01/2020.
//  Copyright © 2020 Razvan-Antonio Berbece. All rights reserved.
//

import Foundation
import DRDatabase

class DB_action {
    
    // private let api_url = "http://10.41.118.87/Config.php" Needs to be changed for local testing
    
    // DB Credentials
    private let phpFile: URL! = URL(string: "http://10.40.21.250/Config.php")
    private let host: URL! = URL(string: "localhost")
    private let databaseName = "users_db"
    private let Username = "root"
    private let password = ""
    
    func submitRegister(user: String, email: String, pass: String) {
        
        //getting values from text fields
        let swift_username = user
        let swift_email = email
        let swift_pass = pass
        
        let connection = DRConnection(host: host, database: databaseName, username: Username, password: password)
        let database = DRDatabase(phpFileUrl: phpFile, connection: connection)
        
        let command = String(format: "INSERT INTO users VALUES ('%@', '%@', '%@')", swift_username, swift_email, swift_pass)
        
        // execute your command
        database.execute(sqlCommand: command) { (detailedJsonObject, error) in
            if let error = error {
                // some error handling
                print("\(error.errorCode!): \(error.errorDescription!)") // Includes URLRequest errors and MySQL syntax/server errors
            }
            if let jsonObject = detailedJsonObject {
                if jsonObject.result?.isEmpty == false {
                    // jsonObject.result! is your data from the database in a [[String:Any]] format
                    print(jsonObject.result! as Any)
                } else {
                    // This happens at a INSERT, UPDATE or DELETE command.
                    print("Command successfully sent and executed by database")
                }
            }
        }
        // cancel a running request
        // database.abortExecution()
    }
    
    func checkCredentials(user: String, pass: String) -> Bool {
        var checked : Bool = false
        
        let connection = DRConnection(host: host, database: databaseName, username: Username, password: password)
        let database = DRDatabase(phpFileUrl: phpFile, connection: connection)
        
        let command_getRecord = String(format: "SELECT * FROM users WHERE username = '%@' AND pass = '%@'", user, pass)
        database.execute(sqlCommand: command_getRecord) { (detailedJsonObject, error) in
            if let error = error {
                // some error handling
                print("\(error.errorCode!): \(error.errorDescription!)") // Includes URLRequest errors and MySQL syntax/server errors
            }
            if let jsonObject = detailedJsonObject {
                if jsonObject.result?.isEmpty == false { checked = true
                    // jsonObject.result! is your data from the database in a [[String:Any]] format
                    print(jsonObject.result! as Any)
                }
                else { checked = false }
            }
        }
        return checked
    }
}
