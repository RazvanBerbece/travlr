//
//  ContentView.swift
//  travlr
//
//  Created by Razvan-Antonio Berbece on 28/01/2020.
//  Copyright © 2020 Razvan-Antonio Berbece. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usernameInput: String = "Enter username here ..."
    @State private var emailInput: String = "Enter email here ..."
    @State private var NullWarning: Text = Text("The form can't be empty. Complete the fields and try again.")
    @State private var EmailWarning: Text = Text("Wrong email format.")
    
    @State private var displayNullWarning: Bool = false
    @State private var displayEmailWarning: Bool = false
    
    private let DBconn = DB_action()
    private let Validator = Validation()
    private let Hash = Hasher()
    
    var body: some View {
        ZStack {
            VStack (spacing: 35.0) {
                Text("travlr.")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.white)
                    .padding(.trailing, 220.0)
                    .padding(.top, -20.0)
                if !self.displayNullWarning && !self.displayEmailWarning {
                    NullWarning
                        .hidden()
                    EmailWarning
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
                ZStack {
                    TextField("", text: $usernameInput)
                        .frame(width: nil)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.975))
                        .background(Color(hue: 0.584, saturation: 0.031, brightness: 0.001, opacity: 0.566))
                        .zIndex(100)
                        .frame(width: 350.0)
                        .cornerRadius(20)
                        .simultaneousGesture(TapGesture().onEnded {
                            self.usernameInput = ""
                        })
                }
                ZStack {
                    TextField("", text: $emailInput)
                        .padding(0.0)
                        .frame(width: 350.0)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.975))
                        .background(Color(hue: 0.584, saturation: 0.031, brightness: 0.001, opacity: 0.566))
                        .zIndex(100)
                        .cornerRadius(20)
                        .simultaneousGesture(TapGesture().onEnded {
                            self.emailInput = ""
                        })
                }
                .padding(.top, -25.0)
                Button(action: {
                    //  print(self.username)
                    if self.emailInput.isEmpty || self.usernameInput.isEmpty {
                        self.displayNullWarning = true
                        self.displayEmailWarning = false;
                    }
                    else if !self.Validator.isValidMailInput(input: self.emailInput) && !self.usernameInput.isEmpty{
                        self.displayEmailWarning = true
                        self.displayNullWarning = false;
                    }
                    else { self.DBconn.submitRegister(user: self.usernameInput, email: self.emailInput)
                        self.displayNullWarning = false
                        self.displayEmailWarning = false
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
            }
            .zIndex(999)
            Image("travlrBG")
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fit/*@END_MENU_TOKEN@*/)
                .zIndex(-1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
