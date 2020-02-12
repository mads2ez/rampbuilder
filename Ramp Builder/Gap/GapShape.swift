//
//  GapShape.swift
//  Ramp Builder
//
//  Created by Madsbook on 23.01.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

struct GapShape: Shape {
    var viewModel: GapShapeModel
    
    init(viewModel: GapShapeModel) {
        self.viewModel = viewModel
    }
    
    func path(in rect: CGRect) -> Path {
        
        let rotationAdjustment = Angle.degrees(270)
        let modifiedStart = Angle.degrees(0) - rotationAdjustment
        let modifiedEnd = Angle.degrees(360-viewModel.gapParams.takeoff.angle) - rotationAdjustment
        let modifiedRadius = rect.width / CGFloat(viewModel.scale) * CGFloat(viewModel.takeoffRadius)
        
        var path = Path()
        
        // Takeoff
        path.addArc(center: CGPoint(x: rect.minX, y: rect.maxY - modifiedRadius), radius: modifiedRadius, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: true)
        
        // x = a + r cos t
        // y = b + r sin t
        
        path.addLine(to: CGPoint(x: modifiedRadius * CGFloat(cos(modifiedEnd.radians)), y: rect.maxY))
        
        // Gap
        path.move(to: CGPoint(x: modifiedRadius * CGFloat(cos(modifiedEnd.radians)) + viewModel.gap * viewModel.step(rect) - (viewModel.table * viewModel.step(rect)), y: rect.maxY))
        
        // Landing
        path.addLine(to: CGPoint(x: modifiedRadius * CGFloat(cos(modifiedEnd.radians)) + (viewModel.gap * viewModel.step(rect)) - (CGFloat(viewModel.gapParams.landing.table) * viewModel.step(rect)), y: rect.maxY - (CGFloat(viewModel.gapParams.landing.height) * viewModel.step(rect))))
        
        // Table
        if viewModel.gapParams.landing.table != 0 {
            path.addLine(to: CGPoint(x: modifiedRadius * CGFloat(cos(modifiedEnd.radians)) + (viewModel.gap * viewModel.step(rect)), y: rect.maxY - (CGFloat(viewModel.gapParams.landing.height ) * viewModel.step(rect))))
        }
        
        path.addLine(to: CGPoint(x: modifiedRadius * CGFloat(cos(modifiedEnd.radians)) + (viewModel.gap * viewModel.step(rect)), y:
            rect.maxY - (CGFloat(viewModel.gapParams.landing.height) * viewModel.step(rect))
        ))
        path.addLine(to: CGPoint(x: modifiedRadius * CGFloat(cos(modifiedEnd.radians)) + (viewModel.gap * viewModel.step(rect)) + (viewModel.landingLength * viewModel.step(rect)), y: rect.maxY))
        
        return path
    }
    
}

struct GapShape_Previews: PreviewProvider {
    static var previews: some View {
        GapShape(viewModel: GapShapeModel(params: GapParams.defaultParams, scale: 10))
        .stroke(Color.blue, lineWidth: 3)
        .frame(width: 300, height: 300)
    }
}
