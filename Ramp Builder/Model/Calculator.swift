//
//  Calculator.swift
//  Ramp Builder
//
//  Created by Madsbook on 23.01.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI
import Combine

class Calculator {

    func calculate(params: CalcParams) -> Double {
        ///...
        return 0.0
    }
}

final class CalcParamsViewModel: ObservableObject {

    @Published var params: CalcParams?

    init(store: CalcParamsStore) {
        self.params = store.get()
    }
}

class GapCalculator: ObservableObject {
    
    @Published var gap: Double? =  UserDefaults.standard.double(forKey: "gap") {
        didSet {
            UserDefaults.standard.set(self.gap, forKey: "gap")
        }
    }
    
    @Published var table: Double? = UserDefaults.standard.double(forKey: "table") {
        didSet {
            UserDefaults.standard.set(self.table, forKey: "table")
        }
    }
    
    @Published var takeoffHeight: Double = UserDefaults.standard.double(forKey: "takeoffHeight") {
       didSet {
           UserDefaults.standard.set(self.takeoffHeight, forKey: "takeoffHeight")
       }
    }
    
    @Published var takeoffAngle: Double = UserDefaults.standard.double(forKey: "takeoffAngle") {
        didSet {
            UserDefaults.standard.set(self.takeoffAngle, forKey: "takeoffAngle")
        }
    }
    
    @Published var landingHeight: Double? = UserDefaults.standard.double(forKey: "landingHeight") {
        didSet {
            UserDefaults.standard.set(self.landingHeight, forKey: "landingHeight")
        }
    }
    
    @Published var landingAngle: Double? = UserDefaults.standard.double(forKey: "landingAngle") {
        didSet {
            UserDefaults.standard.set(self.landingAngle, forKey: "landingAngle")
        }
    }
    
    @Published var speed: Double? = UserDefaults.standard.double(forKey: "speed") {
       didSet {
           UserDefaults.standard.set(self.speed, forKey: "speed")
        }
    }
    
    
    init(gap: Double, table: Double, takeoffHeight: Double, takeoffAngle: Double, landingHeight: Double, landingAngle: Double, speed: Double) {
        self.gap = gap
        self.table = table
        self.takeoffHeight = takeoffHeight
        self.takeoffAngle = takeoffAngle
        self.landingHeight = landingHeight
        self.landingAngle = landingAngle
        self.speed = speed
    }
    
    init(height: Double, angle: Double) {
        self.takeoffHeight = height
        self.takeoffAngle = angle
    }
    
    convenience init() {
        self.init(height: 2, angle: 60)
    }
    
    var takeoffRadius: Double {
        return round(takeoffHeight / (2 * (sin(deg2rad(takeoffAngle) / 2) * sin(deg2rad(takeoffAngle) / 2))) * 100) / 100;
    }
    
    var takeoffLength: Double {
        return (takeoffHeight * (1/sin(deg2rad(takeoffAngle)) + 1/tan(deg2rad(takeoffAngle))))
    }
    
    var landingLength: Double {
        return (landingHeight ?? 0) * tan(deg2rad(90 - (landingAngle ?? 0)))
    }
    
    private func deg2rad(_ number: Double) -> Double {
        return number * .pi / 180
    }
    
    func findRoot() -> Double {
        // ????
        let v0 = (self.speed ?? 0) * 1000 / 3600
        let v0x = v0 * cos(self.takeoffAngle * .pi / 180)
        let v0y = v0 * sin(self.takeoffAngle * .pi / 180)
        let L = pow(v0,2) * sin(self.takeoffAngle * .pi / 180 * 2) / 9.8
        let H = pow(v0,2) * pow(sin(self.takeoffAngle * .pi / 180), 2) / (2 * 9.8)
        
        
        let dp = abs((self.landingHeight ?? 0) / tan((self.landingAngle ?? 0) * .pi / 180))
        
        let a = -9.8 / (2 * pow(v0x, 2))
        let b = v0y / v0x + (self.landingHeight ?? 0) / dp
        let c1 = (self.landingHeight ?? 0) * (self.gap ?? 0) / dp
        let c2 = (self.landingHeight ?? 0) + c1
        
        let c = -c2 + self.takeoffHeight
        
        let diskr = b * b - 4 * a * c
        
        print("v0 = \(v0), v0x = \(v0x), L = \(L), H = \(H), a = \(a), b = \(b), c = \(c), diskr = \(diskr)")
        
        if (diskr<0) {
            print("Нет пересечения траектории с приземлением! \(diskr)")
            return 0
        } else {
            
            // root of the quadratic equation
            let xroot = (-b - sqrt(diskr))/(2*a)
            let vk = sqrt(v0x*v0x + pow((v0y - 9.8 * xroot / v0x),2))
            let fi = atan((v0y - 9.8 * xroot / v0x) / v0x)
            
            print("xroot \(xroot), vk = \(vk), fi = \(fi)")
            
            // landing stiffness
            let stiffness = pow(vk * sin(abs(abs(fi) - ((self.landingAngle ?? 0) * .pi / 180 ))), 2) / (2 * 9.8)
                        
            return stiffness
        }
    }

}
