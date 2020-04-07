//
//  Trajectory.swift
//  Ramp Builder
//
//  Created by Madsbook on 23.01.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

struct Trajectory: Shape {
    
    var gapParams: GapParams
    
    // Jump trajectory
    func path(in rect: CGRect) -> Path {
        
//        // Trajectory from these points
//        let data = Array(0...Int(rect.width * 10)).map{Double($0) / 10}
        
        var path = Path()
        
        path.move(to: CGPoint(x: CGFloat(self.gapParams.takeoffLength) * getStep(rect: rect), y: rect.maxY - CGFloat(self.gapParams.takeoff.height) * getStep(rect: rect)))
         
        for i in getDataArray(rect: rect) {
            if rect.maxY - CGFloat(self.gapParams.takeoff.height) * getStep(rect: rect) - getStep(rect: rect) * self.calcParabola(x: Double(i)) < rect.maxY && CGFloat(self.gapParams.takeoffLength) * getStep(rect: rect) + CGFloat(i) * getStep(rect: rect) < rect.maxX {
                
                path.addLine(to: CGPoint(x: CGFloat(self.gapParams.takeoffLength) * getStep(rect: rect) + CGFloat(i) * getStep(rect: rect), y: rect.maxY - CGFloat(self.gapParams.takeoff.height) * getStep(rect: rect) - getStep(rect: rect) * self.calcParabola(x: Double(i))))
            }
        }
        
        return path
    }
    
}

struct TrajectoryShape: Shape {
    
    var startPoint: CGPoint
    var data: [CGPoint]
    
    func path(in rect: CGRect) -> Path {
        
        var path = Path()
        
        path.move(to: startPoint)
        
        path.addLines(data)
        
        return path
    }
    
}

extension Trajectory {
    
    func calcParabola(x: Double) -> CGFloat {
        let result = (x * tan(self.gapParams.takeoff.angle * .pi / 180)) - (9.8 * pow(x, 2) / (2 * pow(self.gapParams.speed * 0.28, 2) * pow(cos(self.gapParams.takeoff.angle * .pi / 180), 2)))
         
         return CGFloat(result)
    }
    
    func getDataArray(rect: CGRect) -> [Double] {
        return Array(0...Int(rect.width * 10)).map{Double($0) / 10}
    }

    func getStep(rect: CGRect) -> CGFloat {
        let scale = (1 + self.gapParams.takeoffLength + self.gapParams.gap + self.gapParams.landingLength)
        return rect.width / CGFloat(scale)
    }
}


struct Trajectory_Previews: PreviewProvider {
    static var previews: some View {
        Trajectory(gapParams: GapParams.defaultParams)
            .stroke(Color.green, lineWidth: 2)
    }
}
