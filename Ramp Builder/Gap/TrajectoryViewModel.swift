//
//  TrajectoryViewModel.swift
//  Ramp Builder
//
//  Created by Madsbook on 12.02.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

class TrajectoryViewModel {
    var gapParams: GapParams
    var step: CGFloat
    
    init(params: GapParams, step: CGFloat) {
        self.gapParams = params
        self.step = step
    }
    
    var takeoffRadius: Double {
        return GapCalculator.calcTakeoffRadius(height: gapParams.takeoff.height, angle: gapParams.takeoff.angle)
    }
    
    var takeoffLength: CGFloat {
        return CGFloat(GapCalculator.calcTakeoffLength(height: gapParams.takeoff.height, angle: gapParams.takeoff.angle))
    }
    
    var landingLength: Double {
        return GapCalculator.calcLandingLength(height: gapParams.landing.height, angle: gapParams.landing.angle)
    }
    
    func calcParabola(x: Double) -> CGFloat {
        let result = (x * tan(self.gapParams.takeoff.angle * .pi / 180)) - (9.8 * pow(x, 2) / (2 * pow(self.gapParams.speed * 0.28, 2) * pow(cos(self.gapParams.takeoff.angle * .pi / 180), 2)))
         
         return CGFloat(result)
    }
}
