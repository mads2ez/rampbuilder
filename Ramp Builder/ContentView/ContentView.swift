//
//  ContentView.swift
//  Ramp Builder
//
//  Created by Madsbook on 23.01.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var jump: GapCalculator
    
    var body: some View {
            TabView {
                ScrollView() {
                    InputView()
                        .environmentObject(jump)
                }.onTapGesture {
                    UIApplication.shared.endEditing()
                }
                    .tabItem {
                        Image(systemName: "1.circle")
                        Text("Set")
                    }.tag(0)
                
                HStack(alignment: .bottom) {
                    GapView()
                        .frame(minWidth: 200, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
                        .environmentObject(jump)
                        .padding()
                }
                    .tabItem {
                        Image(systemName: "2.circle")
                        Text("Gap")
                    }.tag(1)
                
                HStack(alignment: .bottom) {
                    RampView()
                        .frame(minWidth: 200, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
                        .environmentObject(jump)
                        .padding()
                }
                    .tabItem {
                        Image(systemName: "3.circle")
                        Text("Ramp")
                    }.tag(2)
            }

    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(GapCalculator(height: 2, angle: 60))
    }
}

