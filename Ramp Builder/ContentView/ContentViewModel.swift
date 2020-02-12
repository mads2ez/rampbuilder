//
//  ContentViewModel.swift
//  Ramp Builder
//
//  Created by Madsbook on 10.02.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

final class ContentViewModel {
//    @EnvironmentObject var gapState: GapState
    
    var gapParams: GapParams?
    
    let store = GapParamsUserDefaults()
    var inputViewModel: InputViewModel
    let rampViewModel: RampViewModel
    let gapViewModel: GapViewModel
    
    init(params: GapParams) {
        self.gapParams = params
        self.inputViewModel = InputViewModel(store: store)
        self.rampViewModel = RampViewModel(store: store)
        self.gapViewModel = GapViewModel(store: store)
        
        print(params)
    }
    
    init(store: GapParamsStore) {
        self.gapParams = store.get()
        self.inputViewModel = InputViewModel(store: store)
        self.rampViewModel = RampViewModel(store: store)
        self.gapViewModel = GapViewModel(store: store)
    }
    
//    func fetchStore() {
//        if let store = GapParamsUserDefaults().get() {
//            gapParams = store
//        } else {
//            gapParams = GapParams.defaultParams
//        }
//    }
}
