//
//  SwiftUIView.swift
//  RampBuilder
//
//  Created by Madsbook on 03.07.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

struct SwiftUIView: View {
    @State var text: String = ""
    
    var body: some View {
        VStack {
            Text(text)
            
            TextField("placeholder", text: $text)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
