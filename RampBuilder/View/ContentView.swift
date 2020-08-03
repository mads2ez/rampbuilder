//
//  ContentView.swift
//  RampBuilder
//
//  Created by Madsbook on 03.06.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel
    
    init(viewModel: ContentViewModel) {
        self.viewModel = viewModel
        
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().barTintColor = UIColor(named: "bg")
    }
    
    var body: some View {
        TabView(selection: $viewModel.selection) {
            viewModel.gapView
                .tabItem{
                    Image(systemName: "flip.horizontal.fill")
                    Text("Gap")
                }.tag(0)
            
            ToolsView()
                .tabItem{
                    Image("shovels").renderingMode(.template)
                    Text("Tools")
                }.tag(1)
        }
            .accentColor(Color("accent"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel(params: GapParams.defaultParams)).environment(\.colorScheme, .light).environment(\.locale, .init(identifier: "en"))
    }
}
