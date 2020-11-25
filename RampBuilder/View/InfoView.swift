//
//  InfoView.swift
//  RampBuilder
//
//  Created by Madsbook on 29.04.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

struct InfoView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
//    init() {
//        UITableView.appearance().backgroundColor = UIColor(named: "bg")
//
////        self._navBarHidden = navBarHidden
//    }

//    @Binding var navBarHidden: Bool
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    Text("RampBuilder is a tool for pre-calculation of the ramp dimensions and jump length. Be cautious, these calculations do not take into account riding technique, wind, and other factors. Always evaluate your skills and wear a helmet. Ride more, stay safe!")
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
                        Button(action: {
                            let formattedString = "https://mads2ez.github.io/rampbuilderapp/privacypolicy"
                            guard let url = URL(string: formattedString) else { return }
                            UIApplication.shared.open(url)
                        }) {
                            Text("Privacy Policy")
                        }
                    }
                    
                    HStack {
                        Text("Version")
                        Spacer()
                        Text(getAppVersion()).foregroundColor(Color.gray)
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
                        Text("Dismiss")
                    }))
                .onAppear() {
                    self.logEvent()
    //                self.navBarHidden = false
                }
        }
    }
    
    func getAppVersion() -> String {
        return UIApplication.appVersion ?? "unknown"
    }
    
    func logEvent() {
        AnalyticsManager.instance.logEvent("InfoVIew opened")
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
