//
//  InfoView.swift
//  RampBuilder
//
//  Created by Madsbook on 29.04.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

class InfoViewModel {
    func logEvent(_ event: String) {
        AnalyticsManager.instance.logEvent(event)
    }
}

struct InfoView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    var viewModel: InfoViewModel
    
    init() {
        self.viewModel = InfoViewModel()
    }
    
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
                        
                        self.viewModel.logEvent("Contact developer pressed")
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
                            
                            self.viewModel.logEvent("Privacy Policy pressed")
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
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarItems(
                    leading:
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Dismiss")
                    }))
                .onAppear() {
                    self.viewModel.logEvent("InfoView opened")
                }
        }
    }
    
    func getAppVersion() -> String {
        return UIApplication.appVersion ?? "unknown"
    }
    
    
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
