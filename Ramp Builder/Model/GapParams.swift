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

extension TakeoffParams {
    static let defaultParams: TakeoffParams = {
        var params = TakeoffParams()
        params.height = 2.0
        params.angle = 60
        return params
    }()
}
