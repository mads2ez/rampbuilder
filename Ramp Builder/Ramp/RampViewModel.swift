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
    
    var rampangle: Angle {
        return .degrees(360 - (self.params?.angle ?? 0))
    }
    
    func calcScale(width: CGFloat, height: CGFloat) -> (scale: Int, step: CGFloat) {
        let scale = Int(1 + (self.params?.length ?? 0))
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
}
