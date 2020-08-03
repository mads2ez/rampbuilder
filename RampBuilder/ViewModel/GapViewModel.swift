//
//  GapViewModel.swift
//  RampBuilder
//
//  Created by Madsbook on 11.02.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI
import Combine

class GapViewModel: ObservableObject {
    @Published var gapParams: GapParams
    
    let store: GapParamsStore
    let formatter = MeasurementFormatter()
    
    
    init(store: GapParamsStore) {
        self.store = store
        self.gapParams = store.get() ?? GapParams.defaultParams
        
        formatter.unitOptions = [.providedUnit]
        formatter.numberFormatter.minimumFractionDigits = 0
        formatter.numberFormatter.maximumFractionDigits = 2
    }
    
    convenience init(params: GapParams) {
        self.init(store: GapParamsUserDefaults())
        self.gapParams = params
    }
    
    @Published var inputShown: Bool = false
    @Published var infoShown: Bool = false
    
    var formattedTakeoffHeight: String {
        let height = Measurement(value: gapParams.takeoff.height, unit: UnitLength.meters)
        return formatter.string(from: height)
    }
    
    var formattedTakeoffLength: String {
        let height = Measurement(value: gapParams.takeoffLength, unit: UnitLength.meters)
        return formatter.string(from: height)
    }
    
    var formattedTakeoffAngle: String {
        let angle = Measurement(value: gapParams.takeoff.angle, unit: UnitAngle.degrees)
        formatter.unitStyle = .short
        return formatter.string(from: angle)
    }
    
    var formattedTakeoffRadius: String {
        let value = Measurement(value: gapParams.takeoffRadius, unit: UnitLength.meters)
        formatter.unitStyle = .medium
        return formatter.string(from: value)
    }
    
    var formattedLandingHeight: String {
        let height = Measurement(value: gapParams.landing.height, unit: UnitLength.meters)
        return formatter.string(from: height)
    }
    
    var formattedLandingLength: String {
        let height = Measurement(value: gapParams.landingLength, unit: UnitLength.meters)
        return formatter.string(from: height)
    }
    
    var formattedLandingAngle: String {
        let angle = Measurement(value: gapParams.landing.angle, unit: UnitAngle.degrees)
        formatter.unitStyle = .short
        return formatter.string(from: angle)
    }
    
    var formattedTable: String {
        let height = Measurement(value: gapParams.landing.table, unit: UnitLength.meters)
        formatter.unitStyle = .medium
        return formatter.string(from: height)
    }
    
    var formattedGap: String {
        let height = Measurement(value: gapParams.gap, unit: UnitLength.meters)
        return formatter.string(from: height)
    }
    
    var formattedSpeed: String {
        let speed = Measurement(value: gapParams.speed, unit: UnitSpeed.kilometersPerHour)
        return formatter.string(from: speed)
    }
    
    var formattedMaxHeight: String {
        let height = Measurement(value: gapParams.maxHeight, unit: UnitLength.meters)
        return formatter.string(from: height)
    }
    
    var formattedStiffness: String {
        let stiffness = Measurement(value: gapParams.landingStiffness, unit: UnitLength.meters)
        return formatter.string(from: stiffness)
    }
}

extension GapViewModel {
    func refresh() {
        self.gapParams = store.get() ?? GapParams.defaultParams
    }
    
    var inputView: some View {
        let inputView = InputView(viewModel: .init(store: self.store))
        return inputView
    }
    
}

extension GapViewModel {
    func openEditor() {
        self.inputShown = true
        
        AnalyticsManager.instance.logEvent("Edit button pressed")
    }
    
    func openInfoView() {
        self.infoShown = true
        
        AnalyticsManager.instance.logEvent("Info button pressed")
    }
}
