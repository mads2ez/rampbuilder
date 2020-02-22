//
//  ContentViewModel.swift
//  Ramp Builder
//
//  Created by Madsbook on 10.02.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

final class ContentViewModel: ObservableObject {
    
    var gapParams: GapParams?
    let store: GapParamsStore
    
    init(params: GapParams, store: GapParamsStore = GapParamsUserDefaults()) {
        self.gapParams = params
        self.store = store
        print(params)
    }
    
    init(store: GapParamsStore) {
        self.store = store
        self.gapParams = store.get()
    }
    
    var inputViewModel: InputViewModel {
        return InputViewModel(store: store)
    }
    
    var rampViewModel: RampViewModel {
        return RampViewModel(store: store)
    }
    
    var gapViewModel: GapViewModel {
         return GapViewModel(store: store)
    }
}
