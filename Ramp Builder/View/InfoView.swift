//
//  InfoView.swift
//  Ramp Builder
//
//  Created by Madsbook on 29.04.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

struct InfoView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Jumps can be dangerous and may harm your health. Ramp Builder provides preliminary calculations, which can not be used as a guide. These calculations do not take into account wind and other external factors. Possible health risk is the sole responsibility of the user.")
                .padding()

                
                Spacer()
                
                Button(action: {
                    let formattedString = "mailto:maximsivtsev@gmail.com"
                    guard let url = URL(string: formattedString) else { return }
                    UIApplication.shared.open(url)
                }) {
                   Text("Any feedback is appreciated")
                }
                .padding()
            }
                .navigationBarTitle("Info", displayMode: .inline)
                .navigationBarItems(
                    leading:
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Close")
                    })
                )
        }
    }
}

struct BInfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
