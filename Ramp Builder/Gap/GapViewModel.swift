//
//  GapViewModel.swift
//  Ramp Builder
//
//  Created by Madsbook on 11.02.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

class GapViewModel: ObservableObject {
    @Published var gapParams: GapParams
    var analytics: AnalyticsService?
    
    let store: GapParamsStore
    
    init(store: GapParamsStore) {
        self.store = store
        self.gapParams = store.get() ?? GapParams.defaultParams
    }
    
    convenience init(params: GapParams) {
        self.init(store: GapParamsUserDefaults())
        self.gapParams = params
    }
}

extension GapViewModel {
    func refresh() {
        self.gapParams = store.get() ?? GapParams.defaultParams
    }
    
    var inputView: some View {
        let inputView = InputView(viewModel: .init(store: self.store))
        inputView.viewModel.analytics = self.analytics
        return inputView
    }
}
