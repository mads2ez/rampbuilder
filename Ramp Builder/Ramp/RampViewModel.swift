//
//  RampViewModel.swift
//  Ramp Builder
//
//  Created by Madsbook on 30.01.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

final class RampViewModel: ObservableObject {
    @Published var params: TakeoffParams?

    init(store: GapParamsStore) {
        self.params = store.get()?.takeoff
     }
    
    init(params: GapParams) {
        self.params = params.takeoff
    }
    
    // Helpers
    
    var startAngle: Angle = .degrees(0)
    
    var rampAngle: Angle {
        return .degrees(360 - (self.params?.angle ?? 0))
    }
    
    var rampRadius: Double {
        GapCalculator.calcTakeoffRadius(height: self.params?.height ?? 0, angle: params?.angle ?? 0)
    }
    
    var rampLength: Double {
        GapCalculator.calcTakeoffLength(height: params?.height ?? 0, angle: params?.angle ?? 0)
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
