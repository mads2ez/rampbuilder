//
//  ContentViewModel.swift
//  Ramp Builder
//
//  Created by Madsbook on 10.02.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

final class ContentViewModel: ObservableObject {
    
    var gapParams: GapParams
    let store: GapParamsStore
    
    init(store: GapParamsStore) {
        self.store = store
        self.gapParams = store.get() ?? GapParams.defaultParams
    }
    
    var inputViewModel: InputViewModel {
        return InputViewModel(store: store)
    }
    
    var gapViewModel: GapViewModel {
         return GapViewModel(store: store)
    }
    
    func refresh() {
        self.gapParams = store.get() ?? GapParams.defaultParams
    }
}
