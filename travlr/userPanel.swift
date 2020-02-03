//
//  userPanel.swift
//  travlr
//
//  Created by Razvan-Antonio Berbece on 03/02/2020.
//  Copyright © 2020 Razvan-Antonio Berbece. All rights reserved.
//

import SwiftUI

struct userPanel: View {
    
    @EnvironmentObject var settings: WatchedVariables
    
    private let DBconn = DB_action()
    
    func getDataQueryName() -> String {
        if self.settings.hasLoggedIn {
            let userDataQuery: [[String : Any]] = self.settings.user_data
            return userDataQuery[0]["username"] as! String
        }
        else { return "" }
    }
    
    var body: some View {
        ZStack() {
            VStack() {
                Text("Welcome, \(getDataQueryName())")
                    .font(.title)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .foregroundColor(Color.white)
            }
            .offset(x: -60, y: -195)
            .zIndex(3)
            Image("travlrBG")
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fit/*@END_MENU_TOKEN@*/)
                .zIndex(2)
        }
    }
}

struct userPanel_Previews: PreviewProvider {
    static var previews: some View {
        userPanel().environmentObject(WatchedVariables())
    }
}
