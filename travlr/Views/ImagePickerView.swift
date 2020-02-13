//
//  ImagePicker.swift
//  travlr
//
//  Created by Razvan-Antonio Berbece on 11/02/2020.
//  Copyright © 2020 Razvan-Antonio Berbece. All rights reserved.
//

import SwiftUI

struct ImagePickerView: View {
    
    @EnvironmentObject var settings: WatchedVariables
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ImagePickerViewController(presentationMode: self.presentationMode, image: self.$settings.image)
    }
}

struct ImagePickerView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickerView().environmentObject(WatchedVariables())
    }
}
