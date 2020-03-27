//
//  GapShape.swift
//  Ramp Builder
//
//  Created by Madsbook on 23.01.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

struct GapShape: Shape {
    var gapParams: GapParams
    
    func path(in rect: CGRect) -> Path {
        
        let rotationAdjustment = Angle.degrees(270)
        let modifiedStart = Angle.degrees(0) - rotationAdjustment
        let modifiedEnd = Angle.degrees(360-gapParams.takeoff.angle) - rotationAdjustment
        let modifiedRadius = rect.width / getScale(rect: rect) * CGFloat(gapParams.takeoffRadius)
        
        var path = Path()
        
        // Takeoff
        path.addArc(center: CGPoint(x: rect.minX, y: rect.maxY - modifiedRadius), radius: modifiedRadius, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: true)
        
        // x = a + r cos t
        // y = b + r sin t
        
        path.addLine(to: CGPoint(x: modifiedRadius * CGFloat(cos(modifiedEnd.radians)), y: rect.maxY))
        
        // Gap
        path.move(to: CGPoint(x: modifiedRadius * CGFloat(cos(modifiedEnd.radians)) + CGFloat(gapParams.gap) * getStep(rect: rect) - (CGFloat(gapParams.landing.table) * getStep(rect: rect)), y: rect.maxY))
        
        // Landing
        path.addLine(to: CGPoint(x: modifiedRadius * CGFloat(cos(modifiedEnd.radians)) + (CGFloat(gapParams.gap) * getStep(rect: rect)) - (CGFloat(gapParams.landing.table) * getStep(rect: rect)), y: rect.maxY - (CGFloat(gapParams.landing.height) * getStep(rect: rect))))
        
        // Table
        if gapParams.landing.table != 0 {
            path.addLine(to: CGPoint(x: modifiedRadius * CGFloat(cos(modifiedEnd.radians)) + (CGFloat(gapParams.gap) * getStep(rect: rect)), y: rect.maxY - (CGFloat(gapParams.landing.height ) * getStep(rect: rect))))
        }
        
        path.addLine(to: CGPoint(x: modifiedRadius * CGFloat(cos(modifiedEnd.radians)) + (CGFloat(gapParams.gap) * getStep(rect: rect)), y:
            rect.maxY - (CGFloat(gapParams.landing.height) * getStep(rect: rect))
        ))
        path.addLine(to: CGPoint(x: modifiedRadius * CGFloat(cos(modifiedEnd.radians)) + (CGFloat(gapParams.gap) * getStep(rect: rect)) + (CGFloat(gapParams.landingLength) * getStep(rect: rect)), y: rect.maxY))
        
        return path
    }
}

extension GapShape {
    func getScale(rect: CGRect) -> CGFloat {
        return CGFloat(1 + self.gapParams.takeoffLength + self.gapParams.gap + self.gapParams.landingLength)
    }
    
    func getStep(rect: CGRect) -> CGFloat {
        let scale = self.getScale(rect: rect)
        return rect.width / CGFloat(scale)
    }
}

struct GapShape_Previews: PreviewProvider {
    static var previews: some View {
        GapShape(gapParams: GapParams.defaultParams)
        .stroke(Color.blue, lineWidth: 3)
        .frame(width: 300, height: 300)
    }
}
