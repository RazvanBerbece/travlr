//
//  settingsView.swift
//  travlr
//
//  Created by Razvan-Antonio Berbece on 10/02/2020.
//  Copyright © 2020 Razvan-Antonio Berbece. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct settingsView: View {
    
    @EnvironmentObject var settings: WatchedVariables
    
    var body: some View {
        ZStack {
            VStack {
                Text("Settings")
                    .offset(y: -185)
                    .foregroundColor(Color.white)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Button(action: {
                    
                }) {
                    Text("Change Username")
                        .padding(.vertical, 7.5)
                        .frame(width: 250)
                        .background(Color(hue: 0.584, saturation: 0.031, brightness: 0.001, opacity: 0.566))
                        .cornerRadius(20)
                }
                Button(action: {
                    
                }) {
                    Text("Upload Profile Picture")
                        .padding(.vertical, 7.5)
                        .frame(width: 250)
                        .background(Color(hue: 0.584, saturation: 0.031, brightness: 0.001, opacity: 0.566))
                        .cornerRadius(20)
                }
                .offset(y: 5)
            }
            Button(action: {
                self.settings.editSettings = false
            }) {
                Text("Exit Settings")
                    .foregroundColor(Color.red)
            }
            .offset(x: 0, y: -185)
            Image("travlrBG")
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fit/*@END_MENU_TOKEN@*/)
                .padding(.vertical, 5.0)
                .zIndex(-1)
        }
    }
}

struct settingsView_Previews: PreviewProvider {
    static var previews: some View {
        settingsView().environmentObject(WatchedVariables())
    }
}
