//
//  PickerView.swift
//  Ramp Builder
//
//  Created by Madsbook on 23.01.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

struct PickerView: View {
    @Environment(\.viewController) private var viewControllerHolder: ViewControllerHolder
    
    private var viewController: UIViewController? {
        self.viewControllerHolder.value
    }
        
    @Binding var param: Int
    var items: [String] = Array(0...90).compactMap({String($0) + "°"})
    
    var backgroundColor = Color(UIColor.secondarySystemBackground)
    
    var body: some View {
        let binding = Binding(
            get: { self.param },
            set: { self.param = $0 }
         )
        
        return
            ZStack() {
                Rectangle()
                    .fill(Color(white: 1, opacity: 0.0001))
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        self.viewController?.dismiss(animated: false, completion: nil)
                }
                
            VStack {
                Spacer()
                
                VStack {
                    VStack {
                        Divider()
                    
                        HStack {
                            Spacer()

                            Button(action: {
                                self.viewController?.dismiss(animated: false, completion: nil)
                            }, label: {
                                Text("Done")
                            }).padding()
                        }
                            .frame(height: 30)
                        
                        Divider()
                        
                        }
                            .background(backgroundColor)

                    
                    Picker(selection: binding, label: Text("Angle"), content: {
                        ForEach(0..<items.count, id: \.self) {
                            Text("\(self.items[$0])")
                         }
                     })
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .labelsHidden()
                        .padding(0)
                }
                 .background(BlurView())
            }
                .edgesIgnoringSafeArea(.bottom)

        }
    }
}

struct PickerView_Previews: PreviewProvider {
    @State static var x = 2
    @State static var show = true
    static var previews: some View {
        return PickerView(param: $x)
    }
}
