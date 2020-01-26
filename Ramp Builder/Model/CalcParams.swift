//
//  CalcParams.swift
//  Ramp Builder
//
//  Created by younke on 26.01.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import Foundation

struct CalcParams: Codable {

    struct HeightAngle: Codable {
        var height: Double = 0
        var angle: Double = 0
    }

    var gap: Double = 0
    var table: Double = 0
    var takeoff: HeightAngle = .init()
    var landing: HeightAngle = .init()
    var speed: Double = 0
}

// MARK: - Default Params

extension CalcParams {

    static let defaultParams: CalcParams = {
        var params = CalcParams()
        params.speed = 1.0
        return params
    }()
}

// Calculated helpers

extension CalcParams {

    var someCalculated: Double {
        return 0.0
    }
}
