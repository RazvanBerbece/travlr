//
//  ContentView.swift
//  travlr
//
//  Created by Razvan-Antonio Berbece on 28/01/2020.
//  Copyright © 2020 Razvan-Antonio Berbece. All rights reserved.
//

import SwiftUI
import SwiftyJSON
import DRDatabase

struct ContentView: View {
    
    @State private var username: String = "Enter your travlr name here ..."
    let api_url = "https://trvlrr.000webhostapp.com/dblogic.php"
    
    var body: some View {
        ZStack {
            VStack (spacing: 30) {
                Text("travlr")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.white)
                    .padding(.trailing, 245.0)
                    .padding(.top, -55)
                ZStack {
                    TextField("", text: $username)
                        .padding(0.0)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(hue: 1.0, saturation: 0.003, brightness: 0.997))
                        .background(Color(red: 0.389, green: 0.452, blue: 0.516, opacity: 0.498))
                        .zIndex(100)
                }
                Button(action: {
                    //  print(self.username)
                    self.submitName(input: self.username)
                    
                }) {
                    Text(/*@START_MENU_TOKEN@*/"Sign up as a travlr"/*@END_MENU_TOKEN@*/)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding(.all, 20.0)
                        .foregroundColor(Color.white)
                }
                .background(/*@START_MENU_TOKEN@*/Color(hue: 1.0, saturation: 0.021, brightness: 0.471, opacity: 0.432)/*@END_MENU_TOKEN@*/)
                .cornerRadius(20)
                .overlay(RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray, lineWidth: 1))
                .shadow(radius: 10)
            }
            .zIndex(999)
            Image("travlrBG")
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fit/*@END_MENU_TOKEN@*/)
                .zIndex(-1)
        }
    }
    
    func submitName(input: String) {
        
        //getting values from text fields
        let swift_username = input
        
        let phpFile: URL! = URL(string: "http://192.168.64.2/index.php") // e.g. http://213.123.456.567/DRDatabase.php
        let host: URL! = URL(string: "localhost") // If your database is on the same server as the php file,
        //use 'localhost' , otherwise use the ip address of
        //your database and configure remote access.
        let databaseName = "users_db" // name of your MySQL database
        let Username = "root"
        let password = ""
        
        let connection = DRConnection(host: host, database: databaseName, username: Username, password: password)
        let database = DRDatabase(phpFileUrl: phpFile, connection: connection)
        
        let command = String(format: "INSERT INTO users VALUES ('%@')", swift_username)
        
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
                    print("There is no JSON! Command successfully sent and executed by database")
                }
            }
        }
        
        
        
        // cancel a running request
        // database.abortExecution()
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
