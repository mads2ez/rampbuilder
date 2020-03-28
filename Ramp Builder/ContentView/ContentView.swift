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
            InputView(viewModel: viewModel.inputViewModel)
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("Set")
                }.tag(0)
            
            GapView(viewModel: viewModel.gapViewModel)
                .frame(minWidth: 200, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
                .padding()
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("Gap")
                }.tag(1)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel(store: GapParamsMock()))
    }
}

