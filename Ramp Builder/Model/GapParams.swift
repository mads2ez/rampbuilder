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
        params.landing.height = 2.0
        params.landing.angle = 40
        params.landing.table = 0.5
        params.gap = 2
        params.speed = 20
        return params
    }()
}

extension TakeoffParams {
    static let defaultParams: TakeoffParams = {
        var params = TakeoffParams()
        params.height = 2.0
        params.angle = 60
        return params
    }()
}


extension GapParams {
    var takeoffRadius: Double {
        return GapCalculator.calcTakeoffRadius(height: takeoff.height, angle: takeoff.angle)
    }
    
    var takeoffLength: Double {
        return GapCalculator.calcTakeoffLength(height: takeoff.height, angle: takeoff.angle)
    }
    
    var landingLength: Double {
        return GapCalculator.calcLandingLength(height: landing.height, angle: landing.angle)
    }
    
    var landingStiffness: Double {
        return GapCalculator.calcStiffness(speed: speed, gap: gap, angleTakeoff: takeoff.angle, angleLanding: landing.angle, heightLanding: landing.height, heightTakeoff: takeoff.height)
    }
}
