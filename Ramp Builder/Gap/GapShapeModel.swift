//
//  GapShapeModel.swift
//  Ramp Builder
//
//  Created by Madsbook on 11.02.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

class GapShapeModel {
    @Published var gapParams: GapParams
    var scale: Int
    
    init(params: GapParams, scale: Int) {
        self.gapParams = params
        self.scale = scale
    }
    
    // iOS scale adjustment
    var takeoffRadius: Double {
        return GapCalculator.calcTakeoffRadius(height: gapParams.takeoff.height, angle: gapParams.takeoff.angle)
    }
    
    var landingLength: CGFloat {
        return CGFloat(GapCalculator.calcLandingLength(height: gapParams.landing.height, angle: gapParams.landing.angle))
    }
    
//    let rotationAdjustment = Angle.degrees(270)
//    var modifiedStart: Angle {
//        return Angle.degrees(0) - rotationAdjustment
//    }
//
//    var modifiedEnd: Angle {
//        return Angle.degrees(360-self.gapParams.takeoff.angle) - rotationAdjustment
//    }
//
//    var modifiedRadius: (_ rect: CGRect) -> CGFloat {
//        return  {
//            return $0.width / CGFloat(self.scale) * CGFloat(self.takeoffRadius)
//        }
//    }
    
    var gap: CGFloat {
        return CGFloat(gapParams.gap)
    }
    
    var table: CGFloat {
        return CGFloat(gapParams.landing.table)
    }
     
    var step: (_ rect: CGRect) -> CGFloat {
        return {
            return $0.width / CGFloat(self.scale)
        }
    }
}
