//
//  GapState.swift
//  Ramp Builder
//
//  Created by Madsbook on 09.02.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import Foundation
import Combine

class GapState: ObservableObject {
    
    @Published var gapParams: GapParams
    private var store: GapParamsStore
    
    init(store: GapParamsStore = GapParamsUserDefaults()) {
        self.gapParams = store.get() ?? GapParams.defaultParams
        self.store = store
    }
}

extension GapState: GapParamsStore {
    func set(params: GapParams) {
        self.gapParams = params
        self.store.set(params: params)
    }
    
    func get() -> GapParams? {
        return gapParams
    }
}
