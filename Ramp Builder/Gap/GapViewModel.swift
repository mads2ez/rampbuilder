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
    
    let store: GapParamsStore
    
    init(store: GapParamsStore) {
        self.store = store
        self.gapParams = store.get() ?? GapParams.defaultParams
    }
    
    convenience init(params: GapParams) {
        self.init(store: GapParamsUserDefaults())
        self.gapParams = params
    }
}

extension GapViewModel {
    
    func refresh() {
        self.gapParams = store.get() ?? GapParams.defaultParams
    }
    
    func calcScale(width: CGFloat, height: CGFloat) -> (scale: Int, step: CGFloat) {
        let scale = Int(max((1 + self.gapParams.takeoffLength + self.gapParams.gap + self.gapParams.landingLength), gapParams.maxHeight + 1))
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

extension GapViewModel {
    var startPoint: (_ size: CGSize) -> CGPoint {
        return {
            return CGPoint(x: CGFloat(self.gapParams.takeoffLength) * self.step($0), y: $0.height - CGFloat(self.gapParams.takeoff.height) * self.step($0))
        }
    }
    
    var trajectoryPoints: (_ size: CGSize) -> [CGPoint] {
        return {
            let x = self.getXArray(size: $0)
            
            var result: [CGPoint] = []
            
            for i in x {
                
//                if rect.maxY - CGFloat(self.gapParams.takeoff.height) * getStep(rect: rect) - getStep(rect: rect) * self.calcParabola(x: Double(i)) < rect.maxY && CGFloat(self.gapParams.takeoffLength) * getStep(rect: rect) + CGFloat(i) * getStep(rect: rect) < rect.maxX { }
                    
                let y = self.calcParabola(x: i)
                
                result.append(CGPoint(x: i * Double(self.step($0)) + Double(self.startPoint($0).x), y: Double($0.height) - y * Double(self.step($0)) - self.gapParams.takeoff.height * Double(self.step($0)) ))
            }
            
            return result
        }
    }
    
    func calcParabola(x: Double) -> Double {
        let result = (x * tan(self.gapParams.takeoff.angle * .pi / 180)) - (9.8 * pow(x, 2) / (2 * pow(self.gapParams.speed * 0.28, 2) * pow(cos(self.gapParams.takeoff.angle * .pi / 180), 2)))
         
         return Double(result)
    }
    
    func getXArray(size: CGSize) -> [Double] {
        return Array(0...Int(size.width * 10)).map{Double($0) / 10}
    }
}

extension GapViewModel {
    var inputView: some View {
        return InputView(viewModel: .init(store: self.store))
    }
}
