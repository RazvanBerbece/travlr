//
//  ContentView.swift
//  travlr
//
//  Created by Razvan-Antonio Berbece on 28/01/2020.
//  Copyright © 2020 Razvan-Antonio Berbece. All rights reserved.
//

import SwiftUI
import DRDatabase

struct ContentView: View {
    
    @State private var username: String = "Enter your travlr name here ..."
    private let DBconn = DB_action()
    
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
                    self.DBconn.submitName(input: self.username)
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
