//
//  RampShape.swift
//  Ramp Builder
//
//  Created by Madsbook on 23.01.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

struct RampShape: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var radius: Double
    var clockwise: Bool
    var scale: Int
    
    func path(in rect: CGRect) -> Path {
        
        let rotationAdjustment = Angle.degrees(270)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        let modifiedRadius = rect.width < rect.height ? rect.width / CGFloat(self.scale) * CGFloat(self.radius) : rect.height / CGFloat(self.scale) * CGFloat(self.radius)
        
        
        var path = Path()
        
        path.addArc(center: CGPoint(x: rect.minX, y: rect.maxY - modifiedRadius), radius: modifiedRadius, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
        
//        x = a + r cos t
//        y = b + r sin t
        
        path.addLine(to: CGPoint(x: modifiedRadius * CGFloat(cos(modifiedEnd.radians)), y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            
        return path
    }
}

struct Ramp_Previews: PreviewProvider {
    static var previews: some View {
        RampShape(startAngle: .degrees(0), endAngle: .degrees(360 - 90), radius: 6, clockwise: false, scale: 5)
        .stroke(Color.blue, lineWidth: 3)
        .frame(width: 300, height: 150)
        .offset(x: 0, y: 0)
    }
}
