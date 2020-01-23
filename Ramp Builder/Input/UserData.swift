//
//  UserData.swift
//  Ramp Builder
//
//  Created by Madsbook on 23.01.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

class UserData: ObservableObject {
    
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
    
    @Published var takeoffAngle = 60 {
        didSet {
            if self.takeoffAngle > 90 {
                self.takeoffAngle = 90
            }
            else if self.takeoffAngle < 0 {
                self.takeoffAngle = 0
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
    
    init(_ data: GapCalculator) {
        self.takeoffHeight = data.takeoffHeight.toString(format: ".1") == "0.0" ? "" : data.takeoffHeight.toString(format: ".")
        self.takeoffAngle = Int(data.takeoffAngle)
        self.gap = data.gap?.toString(format: ".1") == "0.0" ? "" : data.gap?.toString(format: ".") ?? ""
        self.table = data.table?.toString(format: ".1") == "0.0" ? "" : data.table?.toString(format: ".") ?? ""
        self.landingHeight = data.landingHeight?.toString(format: ".1") == "0.0" ? "" : data.landingHeight?.toString(format: ".") ?? ""
        self.landingAngle = data.landingAngle?.toInt() ?? Int(0)
        self.speed = data.speed?.toString(format: ".1") == "0.0" ? "" : data.speed?.toString(format: ".") ?? ""
    }
}

