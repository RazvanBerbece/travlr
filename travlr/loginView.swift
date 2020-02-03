//
//  loginView.swift
//  travlr
//
//  Created by Razvan-Antonio Berbece on 01/02/2020.
//  Copyright © 2020 Razvan-Antonio Berbece. All rights reserved.
//

import SwiftUI

struct loginView: View {
    
    @State private var login_username: String = ""
    @State private var login_password: String = ""
    
    @State private var exitPressed: Bool = false
    
    private let DBconn = DB_action()
    private let Hash = Hasher()
    
    @EnvironmentObject var settings: WatchedVariables
    
    var body: some View {
        ZStack {
            Button(action: {
                if(self.exitPressed) {
                    self.settings.exitLoginView = true
                }
                else {
                    self.settings.exitLoginView = false
                }
            }) {
                Text("x")
                    .foregroundColor(Color.red)
            }
            .zIndex(1)
            .offset(x: 160, y: -55)
            .opacity(self.exitPressed ? 0 : 1)
            VStack() {
                Text("Login Panel")
                    .offset(y: 5)
                VStack() {
                    TextField("Username", text: $login_username)
                        .frame(width: nil)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.975))
                        .background(Color(hue: 0.584, saturation: 0.038, brightness: 0.711))
                        .zIndex(100)
                        .frame(width: 350.0)
                    
                    SecureField("Password", text: $login_password)
                        .frame(width: nil)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.975))
                        .background(Color(hue: 0.584, saturation: 0.038, brightness: 0.711))
                        .zIndex(100)
                        .frame(width: 350.0)
                }
                .offset(y: 7.5)
                Button(action: {
                    //  ADD FIELD CHECKER FOR NIL INPUT
                    self.settings.exitLoginView = false
                    
                    if(self.exitPressed) {
                        self.settings.exitLoginView = true
                    }
                    else {
                        self.settings.exitLoginView = false
                    }
                    
                    let returnedValue = self.DBconn.checkCredentials(
                        user: self.login_username,
                        pass: self.login_password,
                        completion: {
                            (isAvailable) -> Void in
                            switch isAvailable {
                            case .success(let query) :
                                if !query.isEmpty {
                                    print("Access Granted !")
                                    DispatchQueue.main.async {
                                        self.settings.user_data = query
                                        self.settings.hasLoggedIn = true
                                    }
                                } else {
                                    print("Access Denied.")
                                }
                            case .failure(let error): print(error)
                            }
                    })
                })
                {
                    Text("Submit")
                        .offset(y: 10)
                }
            }
            .padding(.bottom, 20.0)
            .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.731))
        }
    }
}

struct loginView_Previews: PreviewProvider {
    static var previews: some View {
        loginView().environmentObject(WatchedVariables())
    }
}
