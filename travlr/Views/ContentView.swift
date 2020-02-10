//
//  ContentView.swift
//  travlr
//
//  Created by Razvan-Antonio Berbece on 28/01/2020.
//  Copyright © 2020 Razvan-Antonio Berbece. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ContentView: View {
    
    @State private var usernameInput: String = ""
    @State private var emailInput: String = ""
    @State private var passInput: String = ""
    
    @State private var NullWarning: Text = Text("Some fields are empty. Complete the fields and try again.")
    @State private var EmailWarning: Text = Text("Wrong email format.")
    @State private var signUpSuccessful: Text = Text("Successfully signed up !")
    
    @State private var displaySuccessSignUp: Bool = false
    @State private var displayNullWarning: Bool = false
    @State private var displayEmailWarning: Bool = false
    
    @EnvironmentObject var settings: WatchedVariables
    @State private var overlayOn: Bool = false
    
    private let Validator = Validation()
    
    var body: some View {
        ZStack {
            VStack (spacing: 15.0) {
                Text("travlr.")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.white)
                    .padding(.trailing, 220.0)
                    .padding(.top, -20.0)
                ZStack{
                    if !self.displayNullWarning && !self.displayEmailWarning && !self.displaySuccessSignUp{
                        NullWarning
                            .hidden()
                        EmailWarning
                            .hidden()
                        signUpSuccessful
                            .hidden()
                    }
                    else if self.displayNullWarning && !self.displayEmailWarning {
                        NullWarning
                            .foregroundColor(Color.red)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .frame(width: 300.0, height: 50.0)
                            .font(/*@START_MENU_TOKEN@*/.headline/*@END_MENU_TOKEN@*/)
                    }
                    else if self.displayEmailWarning && !self.displayNullWarning {
                        EmailWarning
                            .foregroundColor(Color.red)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .frame(width: 300.0, height: 50.0)
                            .font(/*@START_MENU_TOKEN@*/.headline/*@END_MENU_TOKEN@*/)
                    }
                    else if self.displaySuccessSignUp {
                        signUpSuccessful
                            .foregroundColor(Color.green)
                    }
                }
                TextField("Username here ...", text: $usernameInput)
                    .frame(width: nil)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.975))
                    .background(Color(hue: 0.584, saturation: 0.031, brightness: 0.001, opacity: 0.566))
                    .zIndex(1)
                    .frame(width: 350.0)
                    .cornerRadius(20)
                TextField("Email here ...", text: $emailInput)
                    .frame(width: 350.0)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.975))
                    .background(Color(hue: 0.584, saturation: 0.031, brightness: 0.001, opacity: 0.566))
                    .zIndex(1)
                    .cornerRadius(20)
                SecureField("Password here ...", text: $passInput)
                    .padding(0.0)
                    .frame(width: 350.0)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.975))
                    .background(Color(hue: 0.584, saturation: 0.031, brightness: 0.001, opacity: 0.566))
                    .zIndex(1)
                    .cornerRadius(20)
                Button(action: {
                    //  print(self.username)
                    if self.emailInput.isEmpty || self.usernameInput.isEmpty || self.passInput.isEmpty {
                        self.displayNullWarning = true
                        self.displayEmailWarning = false;
                    }
                    else if !self.Validator.isValidMailInput(input: self.emailInput) && !self.usernameInput.isEmpty{
                        self.displayEmailWarning = true
                        self.displayNullWarning = false;
                    }
                    else {
                        Auth.auth().createUser(withEmail: self.emailInput, password: self.passInput) { (user, error) in
                            if error == nil {
                                print("Sign-Up Successful.")
                                self.displayNullWarning = false
                                self.displayEmailWarning = false
                                self.displaySuccessSignUp = true
                            }
                            else { print("error = \(error)") }
                        }
                    }
                }) {
                    Text(/*@START_MENU_TOKEN@*/"Sign up as a travlr"/*@END_MENU_TOKEN@*/)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding(.all, 20.0)
                        .foregroundColor(Color.white)
                        .frame(width: 250.0, height: 45.0)
                }
                .background(/*@START_MENU_TOKEN@*/Color(hue: 1.0, saturation: 0.021, brightness: 0.471, opacity: 0.432)/*@END_MENU_TOKEN@*/)
                .cornerRadius(20)
                .overlay(RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray, lineWidth: 1))
                .shadow(radius: 10)
                Button(action: {
                    if !self.settings.exitLoginView {
                        self.settings.exitLoginView = true
                    }
                    else {
                        self.settings.exitLoginView = false
                    }
                }) {
                    Text("Already signed-up")
                }
            }
            .zIndex(3)
            .allowsHitTesting(self.settings.exitLoginView ? false : true)
            .blur(radius: self.settings.exitLoginView ? 5.0 : 0)
            Image("travlrBG")
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fit/*@END_MENU_TOKEN@*/)
                .zIndex(0)
                .blur(radius: self.settings.exitLoginView ? 5.0 : 0)
                .opacity(self.settings.hasLoggedIn ? 0 : 1)
            loginView()
                .cornerRadius(20.0)
                .zIndex(9999)
                .opacity(self.settings.exitLoginView ? 1 : 0)
            userPanel()
                .opacity(self.settings.hasLoggedIn ? 1 : 0)
                .frame(width: 100, height: 100, alignment: .center)
                .zIndex(self.settings.hasLoggedIn ? 4 : 0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(WatchedVariables())
    }
}
