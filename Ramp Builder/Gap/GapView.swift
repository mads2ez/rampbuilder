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
            VStack {
                ZStack {
                    GridView(step: self.viewModel.step(geometry.size), color: Color.gray)
                    
                    GapShape(gapParams: self.viewModel.gapParams)
                        .stroke(Color.blue, lineWidth: 2)
                    
                    Trajectory(gapParams:  self.viewModel.gapParams)
                        .stroke(Color.green, lineWidth: 2)
                    
                    TrajectoryShape(startPoint: self.viewModel.startPoint(CGSize(width: geometry.size.width, height: geometry.size.height/3)), data: self.viewModel.trajectoryPoints(CGSize(width: geometry.size.width, height: geometry.size.height/3)))
                        .stroke(Color.yellow, lineWidth: 2)

                }
                    .background(Color.white)
                    .padding()
                    .frame(width: geometry.size.width, height: geometry.size.height/3)
                
                LegendView(gapParams: self.viewModel.gapParams, backgroundColor: Color.white)
                    .frame(width: geometry.size.width, height: geometry.size.height/2)
                
                Spacer()
            }
        
        }
        .onAppear(perform: viewModel.refresh)
    }
}

struct GapView_Previews: PreviewProvider {
    static var previews: some View {
        GapView(viewModel: GapViewModel(params: GapParams.defaultParams))
        .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
    }
}
