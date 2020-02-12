//
//  ContentView.swift
//  Ramp Builder
//
//  Created by Madsbook on 23.01.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var viewModel: ContentViewModel
    
    init(viewModel: ContentViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
            TabView {
                ScrollView() {
                    InputView(viewModel: viewModel.inputViewModel)
                }.onTapGesture {
                    UIApplication.shared.endEditing()
                }
                    .tabItem {
                        Image(systemName: "1.circle")
                        Text("Set")
                    }.tag(0)
                
                HStack(alignment: .bottom) {
                    GapView(viewModel: viewModel.gapViewModel)
                        .frame(minWidth: 200, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
                        .padding()
                }
                    .tabItem {
                        Image(systemName: "2.circle")
                        Text("Gap")
                    }.tag(1)
                
                HStack(alignment: .bottom) {
                    RampView(viewModel: viewModel.rampViewModel)
                        .frame(minWidth: 200, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
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
        ContentView(viewModel: ContentViewModel(params: GapParams.defaultParams))
    }
}

