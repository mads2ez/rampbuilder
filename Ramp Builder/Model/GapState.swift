//
//  GapState.swift
//  Ramp Builder
//
//  Created by Madsbook on 09.02.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI
import Combine

class GapState: ObservableObject {
    
    @Published var takeoff: TakeoffParams
    @Published var landing: LandingParams?
    @Published var gap: Double?
    @Published var speed: Double?
    
    init(params: GapParams) {
        self.takeoff = params.takeoff
        self.landing = params.landing
        self.gap = params.gap
        self.speed = params.speed
    }
    
    init(store: GapParamsStore) {
        self.takeoff = store.get()?.takeoff ?? TakeoffParams.defaultParams
        self.landing = store.get()?.landing
        self.gap = store.get()?.gap
        self.speed = store.get()?.speed
    }
    
    init(takeoffParams: TakeoffParams) {
        self.takeoff = takeoffParams
    }
}
