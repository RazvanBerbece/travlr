//
//  userPanel.swift
//  travlr
//
//  Created by Razvan-Antonio Berbece on 03/02/2020.
//  Copyright © 2020 Razvan-Antonio Berbece. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import SDWebImageSwiftUI

struct userPanel: View {
    
    @EnvironmentObject var settings: WatchedVariables
    private let screenSize: CGRect = UIScreen.main.bounds
    
    private let user = UserStruct(user: Auth.auth().currentUser!)
    private var storageHandler = StorageHandler()
    
    var body: some View {
        ZStack() {
            VStack() {
                Text("Welcome, \(self.user.email ?? "default")")
                    .font(.title)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .foregroundColor(Color.white)
                    .offset(x: -60, y: -195)
                WebImage(url: self.user.photoURL)
                    .onSuccess { image, cacheType in
                        print(image)
                }
                .resizable()
                .cornerRadius(60)
                .frame(width: 80.0, height: 80.0)
                .offset(y: -175)
                /*
                 Image(uiImage: self.storageHandler.downloadImage(from: self.user.photoURL))
                 .resizable()
                 .cornerRadius(60)
                 .frame(width: 80.0, height: 80.0)
                 .offset(y: -175)
                 */
                Button(action: {
                    self.settings.editSettings = true
                }) {
                    Text("Settings")
                        .font(.headline)
                        // .background(Color.white)
                        .multilineTextAlignment(.center)
                        .frame(width: 325, height: 25, alignment: .center)
                        .background(Color(hue: 0.689, saturation: 0.448, brightness: 0.13, opacity: 0.81))
                        .foregroundColor(Color.white)
                        .cornerRadius(35.0)
                }
                .offset(y: -150)
            }
            .zIndex(3)
            Image("travlrBG")
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fit/*@END_MENU_TOKEN@*/)
                .zIndex(2)
            settingsView()
                .opacity(self.settings.editSettings ? 1 : 0)
                .frame(width: 100, height: 100, alignment: .center)
                .zIndex(self.settings.editSettings ? 5 : 0)
        }
    }
}

struct userPanel_Previews: PreviewProvider {
    static var previews: some View {
        userPanel().environmentObject(WatchedVariables())
    }
}
