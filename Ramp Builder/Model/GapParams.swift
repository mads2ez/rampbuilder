//
//  GapParams.swift
//  Ramp Builder
//
//  Created by Madsbook on 28.01.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import Foundation
import Combine

struct TakeoffParams: Codable {
    var height: Double = 0
    var angle: Double = 0
}

struct LandingParams: Codable {
    var height: Double = 0
    var angle: Double = 0
    var table: Double = 0
}

struct GapParams: Codable {
    var takeoff: TakeoffParams = .init()
    var landing: LandingParams = .init()
    var gap: Double = 0
    var speed: Double = 0
}

// MARK: - Default Params
extension GapParams {
    static let defaultParams: GapParams = {
        var params = GapParams()
        params.takeoff.height = 2.0
        params.takeoff.angle = 60
        return params
    }()
}

// Calculated params
extension TakeoffParams {
    var radius: Double {
        return round(height / (2 * (sin(angle.deg2rad() / 2) * sin(angle.deg2rad() / 2))) * 100) / 100;
    }
    
    var length: Double {
        return (height * (1/sin(angle.deg2rad()) + 1/tan(angle.deg2rad())))
    }
}

extension LandingParams {
    var length: Double {
        return height * tan((90 - angle).deg2rad())
    }
}

extension GapParams {
    
    var stiffness: Double {
        // ????
        let v0 = speed * 1000 / 3600
        let v0x = v0 * cos(takeoff.angle.deg2rad())
        let v0y = v0 * sin(takeoff.angle.deg2rad())
        let L = pow(v0,2) * sin(takeoff.angle.deg2rad() * 2) / 9.8
        let H = pow(v0,2) * pow(sin(takeoff.angle.deg2rad()), 2) / (2 * 9.8)
        
        
        let dp = abs(landing.height / tan(landing.angle.deg2rad()))
        
        let a = -9.8 / (2 * pow(v0x, 2))
        let b = v0y / v0x + landing.height / dp
        let c1 = landing.height * gap / dp
        let c2 = landing.height + c1
        
        let c = -c2 + takeoff.height
        
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
            let stiffness = pow(vk * sin(abs(abs(fi) - landing.angle.deg2rad())), 2) / (2 * 9.8)
                        
            return stiffness
        }
    }
}
