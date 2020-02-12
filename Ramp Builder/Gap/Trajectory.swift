//
//  Trajectory.swift
//  Ramp Builder
//
//  Created by Madsbook on 23.01.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

struct Trajectory: Shape {
    
    var viewModel: TrajectoryViewModel
    
    init(viewModel: TrajectoryViewModel) {
        self.viewModel = viewModel
    }
    
    // Flight trajectory
    func path(in rect: CGRect) -> Path {
        
        // Trajectory from these points
        let data = Array(0...Int(rect.width * 10)).map{Double($0) / 10}
        
        var path = Path()
        
        path.move(to: CGPoint(x: self.viewModel.takeoffLength * viewModel.step, y: rect.maxY - CGFloat(self.viewModel.gapParams.takeoff.height) * viewModel.step))
         
        for i in data {
            if rect.maxY - CGFloat(viewModel.gapParams.takeoff.height) * viewModel.step - viewModel.step * viewModel.calcParabola(x: Double(i)) < rect.maxY && viewModel.takeoffLength * viewModel.step + CGFloat(i) * viewModel.step < rect.maxX {
                
                path.addLine(to: CGPoint(x: self.viewModel.takeoffLength * viewModel.step + CGFloat(i) * viewModel.step, y: rect.maxY - CGFloat(self.viewModel.gapParams.takeoff.height) * viewModel.step - viewModel.step * viewModel.calcParabola(x: Double(i))))
            }
        }
        
        return path
    }
}
