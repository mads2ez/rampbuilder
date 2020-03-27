//
//  LegendViewModel.swift
//  Ramp Builder
//
//  Created by Madsbook on 12.02.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

class LegendViewModel {
    var gapParams: GapParams
    var backgroundColor: Color
    
    init(params: GapParams, color: Color = Color(red: 0, green: 0, blue: 0, opacity: 0.2)) {
        self.gapParams = params
        self.backgroundColor = color
    }
    
    var takeoffRadius: Double {
        return GapCalculator.calcTakeoffRadius(height: gapParams.takeoff.height, angle: gapParams.takeoff.angle)
    }
    
    var takeoffLength: Double {
        return GapCalculator.calcTakeoffLength(height: gapParams.takeoff.height, angle: gapParams.takeoff.angle)
    }
    
    var landingLength: Double {
        return GapCalculator.calcLandingLength(height: gapParams.landing.height, angle: gapParams.landing.angle)
    }
    
    var stiffness: Double {
        return GapCalculator.calcStiffness(speed: gapParams.speed, gap: gapParams.gap, angleTakeoff: gapParams.takeoff.angle, angleLanding: gapParams.landing.angle, heightLanding: gapParams.landing.height, heightTakeoff: gapParams.takeoff.height)
    }
}
