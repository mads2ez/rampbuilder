//
//  RampTextFieldView.swift
//  Ramp Builder
//
//  Created by Madsbook on 23.01.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

struct RampTextFieldView: View {
    var title: String
    var placeholder: String
    @Binding var value: String
    
    var body: some View {
        VStack() {
            HStack {
                Text(self.title)
                    .font(.headline)
                
                Spacer()
                                
                TextField(self.placeholder, text: self.$value)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            
            Divider()
        }
            .frame(height: 35)
    }
}

struct RampTextFieldView_Previews: PreviewProvider {
    @State static var text = "meters"
    static var previews: some View {
        RampTextFieldView(title: "Landing", placeholder: "meters", value: $text)
    }
}
