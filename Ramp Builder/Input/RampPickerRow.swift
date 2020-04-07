//
//  RampPickerRow.swift
//  Ramp Builder
//
//  Created by Madsbook on 23.01.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

struct RampPickerRow: View {
    @Environment(\.viewController) private var viewControllerHolder: ViewControllerHolder
    private var viewController: UIViewController? {
        self.viewControllerHolder.value
    }
    
    var title: String
    @Binding var value: Int
    
    var body: some View {
        VStack() {
            HStack {
                Text(self.title)
                
                Spacer()
                
                Text("\(self.value)°")

            }
            
            Divider()
        }
            .padding(.horizontal)
            .contentShape(Rectangle())
            .frame(height: 35)
//            .onTapGesture {
//                self.viewController?.present(presentationStyle: .overCurrentContext, animated: true) {
//                PickerView(param: self.$value)
//                }
//            }
    }
     
}

struct RampPickerRow_Previews: PreviewProvider {
    @State static var val = 2
    static var previews: some View {
        RampPickerRow(title: "Angle", value: $val)
    }
}
