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
            List {
                Section {
                    Text("Ramp Builder is a tool for pre-calculation of the ramp dimensions and jump length. Be cautious, these calculations do not take into account riding technique, wind, and other factors. Always evaluate your skills and wear a helmet. Ride more, stay safe!")
                        .padding(.vertical)
                }
                
                Section() {
                    Button(action: {
                        let formattedString = "mailto:maxim.sivtsev@icloud.com"
                        guard let url = URL(string: formattedString) else { return }
                        UIApplication.shared.open(url)
                    }) {
                       Text("Contact a developer")
                    }
                }
                
                
                Section {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0").foregroundColor(Color.gray)
                    }
                    
                }
            }
                .listStyle(GroupedListStyle())
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
