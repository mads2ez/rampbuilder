//
//  Trajectory.swift
//  Ramp Builder
//
//  Created by Madsbook on 23.01.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

struct Trajectory: Shape {

    var jump: GapCalculator
    var step: CGFloat
    
    // Flight trajectory
    func path(in rect: CGRect) -> Path {
        
        // Trajectory from these points
        let data = Array(0...Int(rect.width * 10)).map{Double($0) / 10}
        
        var path = Path()
        
        path.move(to: CGPoint(x: CGFloat(self.jump.takeoffLength) * step, y: rect.maxY - CGFloat(self.jump.takeoffHeight) * step))
         
        for i in data {
            if rect.maxY - CGFloat(self.jump.takeoffHeight) * step - step * CGFloat(calcParabola(x: Double(i))) < rect.maxY && CGFloat(self.jump.takeoffLength) * step + CGFloat(i) * step < rect.maxX {
                
                path.addLine(to: CGPoint(x: CGFloat(self.jump.takeoffLength) * step + CGFloat(i) * step, y: rect.maxY - CGFloat(self.jump.takeoffHeight) * step - step * CGFloat(calcParabola(x: Double(i)))))
            }
        }
        
        return path
    }
    
    func calcParabola(x: Double) -> (Double) {
        let result = (x * tan(self.jump.takeoffAngle * .pi / 180)) - (9.8 * pow(x, 2) / (2 * pow((self.jump.speed ?? 0) * 0.28, 2) * pow(cos(self.jump.takeoffAngle * .pi / 180), 2)))
        
        return result
    }
}
