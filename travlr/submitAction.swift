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
    
    private let api_url = "http://10.40.21.250/Config.php"
    
    func submitRegister(user: String, email: String) {
        
        //getting values from text fields
        let swift_username = user
        let swift_email = email
        
        let phpFile: URL! = URL(string: "\(api_url)")
        let host: URL! = URL(string: "localhost") // If your database is on the same server as the php file,
        //use 'localhost' , otherwise use the ip address of
        //your database and configure remote access.
        let databaseName = "users_db" // name of your MySQL database
        let Username = "root"
        let password = ""
        
        let connection = DRConnection(host: host, database: databaseName, username: Username, password: password)
        let database = DRDatabase(phpFileUrl: phpFile, connection: connection)
        
        let command = String(format: "INSERT INTO users VALUES ('%@', '%@')", swift_username, swift_email)
        
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
}
