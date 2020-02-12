//
//  GapView.swift
//  Ramp Builder
//
//  Created by Madsbook on 23.01.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

struct GapView: View {
    @ObservedObject var viewModel: GapViewModel
    
    init(viewModel: GapViewModel) {
        self.viewModel = viewModel
    }
        
    var body: some View {
        GeometryReader { geometry in
            GridView(step: self.viewModel.step(geometry.size), color: Color.gray)
            
            GapShape(viewModel: GapShapeModel(params: self.viewModel.gapParams, scale: self.viewModel.scale(geometry.size)))
                .stroke(Color.blue, lineWidth: 2)
                .frame(width: geometry.size.width, height: geometry.size.height)
            
            Trajectory(viewModel: TrajectoryViewModel(params: self.viewModel.gapParams, step: self.viewModel.step(geometry.size)))
                .stroke(Color.green, lineWidth: 2)
            
            LegendView(viewModel: LegendViewModel(params: self.viewModel.gapParams))
        }
    }
}

struct GapView_Previews: PreviewProvider {
    static var previews: some View {
        GapView(viewModel: GapViewModel(params: GapParams.defaultParams))
            .frame(width: 300, height: 150)
    }
}
