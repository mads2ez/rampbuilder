//
//  ContentViewModel.swift
//  RampBuilder
//
//  Created by Madsbook on 03.06.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    let store: GapParamsStore
    var params: GapParams
    
    init(store: GapParamsStore) {
        self.store = store
        self.params = store.get() ?? GapParams.defaultParams
    }
    
    convenience init(params: GapParams) {
        self.init(store: GapParamsUserDefaults())
        self.params = params
    }
    
    @Published var selection = 0
    
    var gapView: some View {
        let view = GapView(viewModel: .init(store: self.store))
        return view
    }
    
}
