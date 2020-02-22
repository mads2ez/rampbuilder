//
//  RampViewModel.swift
//  Ramp Builder
//
//  Created by Madsbook on 30.01.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

final class RampViewModel: ObservableObject {
    @Published var gapParams: GapParams
    
    var store: GapParamsStore = GapParamsUserDefaults()
    
    init(gapParams: GapParams) {
        self.gapParams = gapParams
    }
     
    init(store: GapParamsStore) {
        self.store = store
        self.gapParams = store.get() ?? GapParams.defaultParams
    }
    
    func refresh() {
        self.gapParams = store.get() ?? GapParams.defaultParams
    }
    
    // Helpers
    
    var startAngle: Angle = .degrees(0)
    
    var rampAngle: Angle {
        return .degrees(360 - (self.gapParams.takeoff.angle ))
    }
    
    var rampRadius: Double {
        return GapCalculator.calcTakeoffRadius(height: gapParams.takeoff.height, angle: gapParams.takeoff.angle)
    }
    
    var rampLength: Double {
        return GapCalculator.calcLandingLength(height: gapParams.landing.height, angle: gapParams.landing.angle)
    }
    
    func calcScale(width: CGFloat, height: CGFloat) -> (scale: Int, step: CGFloat) {
        let scale = Int(1 + rampLength)
        let step = width < height ? width / CGFloat(scale) : height / CGFloat(scale)
                
        return (scale: scale, step: step)
    }

    func calcScale(size: CGSize) -> (scale: Int, step: CGFloat) {
        return calcScale(width: size.width, height: size.height)
    }

    var step: (_ size: CGSize) -> CGFloat {
        return {
            return self.calcScale(size: $0).step
        }
    }
    
    var scale: (_ size: CGSize) -> Int {
        return {
            return self.calcScale(size: $0).scale
        }
    }
}
