//
//  GapShape.swift
//  Ramp Builder
//
//  Created by Madsbook on 23.01.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

struct GapShape: Shape {
    var jump: GapCalculator
    var scale: Int
    
    func path(in rect: CGRect) -> Path {
        
        // iOS scale adjustment
        let rotationAdjustment = Angle.degrees(270)
        let modifiedStart = Angle.degrees(0) - rotationAdjustment
        let modifiedEnd = Angle.degrees(360-self.jump.takeoffAngle) - rotationAdjustment
        let modifiedRadius = rect.width / CGFloat(self.scale) * CGFloat(jump.takeoffRadius)
        
        let step = rect.width / CGFloat(self.scale)
        
        var path = Path()
        
        // Takeoff
        path.addArc(center: CGPoint(x: rect.minX, y: rect.maxY - modifiedRadius), radius: modifiedRadius, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: true)
        
        // x = a + r cos t
        // y = b + r sin t
        
        path.addLine(to: CGPoint(x: modifiedRadius * CGFloat(cos(modifiedEnd.radians)), y: rect.maxY))
        
        // Gap
        path.move(to: CGPoint(x:modifiedRadius * CGFloat(cos(modifiedEnd.radians)) + (CGFloat(jump.gap ?? 0) * step) - (CGFloat(jump.table ?? 0) * step), y: rect.maxY))
        
        // Landing
        path.addLine(to: CGPoint(x:modifiedRadius * CGFloat(cos(modifiedEnd.radians)) + (CGFloat(jump.gap ?? 0) * step) - (CGFloat(jump.table ?? 0) * step), y: rect.maxY - (CGFloat(jump.landingHeight ?? 0) * step)))
        
        // Table
        if jump.table != 0 {
            path.addLine(to: CGPoint(x:modifiedRadius * CGFloat(cos(modifiedEnd.radians)) + (CGFloat(jump.gap ?? 0) * step), y: rect.maxY - (CGFloat(jump.landingHeight ?? 0) * step)))
        }
        
        path.addLine(to: CGPoint(x:modifiedRadius * CGFloat(cos(modifiedEnd.radians)) + (CGFloat(jump.gap ?? 0) * step), y:
            rect.maxY - (CGFloat(jump.landingHeight ?? 0) * step)
        ))
        path.addLine(to: CGPoint(x: modifiedRadius * CGFloat(cos(modifiedEnd.radians)) + (CGFloat(jump.gap ?? 0) * step) + (CGFloat(jump.landingLength) * step), y: rect.maxY))
        
        return path
    }
    
}

struct GapShape_Previews: PreviewProvider {
    static var previews: some View {
        GapShape(jump: GapCalculator(gap: 2, table: 1, takeoffHeight: 2, takeoffAngle: 60, landingHeight: 2, landingAngle: 30, speed: 19), scale: 10)
        .stroke(Color.blue, lineWidth: 3)
        .frame(width: 300, height: 300)
    }
}
