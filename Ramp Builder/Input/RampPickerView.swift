//
//  RampPickerView.swift
//  Ramp Builder
//
//  Created by Madsbook on 07.04.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

struct RampPickerView: View {
    @Binding var index: Int
    var values: [String]
    
    var body: some View {
        Picker(selection: $index, label: Text(""), content: {
           ForEach(0..<values.count, id: \.self) {
            Text("\(self.values[$0])")
            }
        })
            .labelsHidden()
            .pickerStyle(WheelPickerStyle())
    }
}
