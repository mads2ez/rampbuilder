//
//  InputViewModel.swift
//  RampBuilder
//
//  Created by Madsbook on 23.01.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

class InputViewModel: ObservableObject {
    
    let store: GapParamsStore
    var params: GapParams
    let formatter = NumberFormatter()
        
    init(store: GapParamsStore) {
        self.store = store
        self.params = store.get() ?? GapParams.defaultParams
        
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        
        self.takeoffHeight = (params.takeoff.height == 0 ? "" : formatter.string(for: params.takeoff.height)) ?? ""
        self.takeoffAngle = Int(params.takeoff.angle)
        self.gap = (params.gap == 0 ? "" : formatter.string(for: params.gap)) ?? ""
        self.table = (params.landing.table == 0 ? "" : formatter.string(for: params.landing.table)) ?? ""
        self.landingHeight = (params.landing.height == 0 ? "" : formatter.string(for: params.landing.height)) ?? ""
        self.landingAngle = params.landing.angle.toInt() ?? Int(0)
        self.speed = (params.speed == 0 ? "" : formatter.string(for: params.speed)) ?? ""
    }
    
    convenience init(params: GapParams) {
        self.init(store: GapParamsUserDefaults())
        self.params = params
    }
    
    
    @Published var takeoffHeight = "" {
       didSet {
           if Double(self.takeoffHeight.replaceComma()) ?? 0 > 5 {
               self.takeoffHeight = "5"
           }
           else if Double(self.takeoffHeight.replaceComma()) ?? 0 < 0 {
               self.takeoffHeight = "0"
           }
       }
    }
    
    @Published var takeoffAngle: Int = 60
    
    @Published var gap: String = "" {
        didSet {
            if Double(self.gap.replaceComma()) ?? 0 > 25 {
                self.gap = "25"
            }
            else if Double(self.gap.replaceComma()) ?? 0 < 0 {
                self.gap = "0"
            }
        }
    }
    
    @Published var table = "" {
        didSet {
            if Double(self.table.replaceComma()) ?? 0 > Double(self.gap.replaceComma()) ?? 0 {
                self.table = gap
            }
            else if Double(self.table.replaceComma()) ?? 0 > 10 {
                self.table = "10"
            }
        }
    }
    
    @Published var landingHeight = "" {
        didSet {
            if Double(self.landingHeight.replaceComma()) ?? 0 > 5 {
                self.landingHeight = "5"
            }
            else if Double(self.landingHeight.replaceComma()) ?? 0 < -5 {
                self.landingHeight = "-5"
            }
        }
    }
    
    @Published var landingAngle = 0 {
       didSet {
           if self.takeoffAngle > 90 {
               self.takeoffAngle = 90
           }
           else if self.takeoffAngle < 0 {
               self.takeoffAngle = 0
           }
       }
    }
    
    @Published var speed = "" {
       didSet {
           if Double(self.speed.replaceComma()) ?? 0 > 70 {
               self.speed = "70"
           }
           else if Double(self.speed.replaceComma()) ?? 0 < 0 {
               self.speed = "0"
           }
       }
    }
    
    @Published var takeoffPickerIsShown = false
    @Published var landingPickerIsShown = false
    
    var possibleAngleRange: [String] = Array(0...89 ).compactMap({String($0) + "°"})
    
    var isValid: Bool {
        if (self.gap.isEmpty || self.table.isEmpty || self.takeoffHeight.isEmpty || self.landingHeight.isEmpty || self.speed.isEmpty) {
            return false
        }
        return true
    }
    
    func saveInput() {
        self.params.takeoff.height = Double(self.takeoffHeight.replaceComma()) ?? 0
        self.params.takeoff.angle = Double( self.takeoffAngle)
        self.params.gap = Double(self.gap.replaceComma()) ?? 0
        self.params.landing.table = Double(self.table.replaceComma()) ?? 0
        self.params.landing.height = Double(self.landingHeight.replaceComma()) ?? 0
        self.params.landing.angle = Double(self.landingAngle)
        self.params.speed = Double(self.speed.replaceComma()) ?? 0
        
        store.set(params: params)
        
        print("height \(String(describing: self.params.takeoff.height)), angle \(String(describing: self.params.takeoff.angle)), land height \(String(describing: self.params.landing.height)), land angle \(String(describing: self.params.landing.angle))")
        
        
        // MARK: - Analytics -
        let props = ["takeoff height": String(describing: self.params.takeoff.height), "takeoff angle": String(describing: self.params.takeoff.angle), "takeoff radius": String(describing: self.params.takeoffRadius), "landing height": String(describing: self.params.landing.height), "landing angle": String(describing: self.params.landing.angle), "landing table": String(describing: self.params.landing.table), "gap": String(describing: self.params.gap), "speed": String(describing: self.params.speed), "stiffness": String(describing: self.params.landingStiffness), "max height": String(describing: self.params.maxHeight)]
        
        AnalyticsManager.instance.logEvent("Calculate", eventProperties: props)

    }
}
