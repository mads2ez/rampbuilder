//
//  GapViewModel.swift
//  Ramp Builder
//
//  Created by Madsbook on 11.02.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

class GapViewModel: ObservableObject {
    @Published var gapParams: GapParams
    
    private let store = GapParamsUserDefaults()
    
    init(params: GapParams) {
        self.gapParams = params
    }
    
    convenience init(store: GapParamsStore) {
        self.init(params: store.get() ?? GapParams.defaultParams)
    }
}

extension GapViewModel {
    
    func refresh() {
        self.gapParams = store.get() ?? GapParams.defaultParams
    }
    
    func calcScale(width: CGFloat, height: CGFloat) -> (scale: Int, step: CGFloat) {
        let scale = Int(1 + self.gapParams.takeoffLength + self.gapParams.gap + self.gapParams.landingLength)
        let step = width / CGFloat(scale)
                
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
