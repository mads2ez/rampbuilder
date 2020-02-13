//
//  RampView.swift
//  Ramp Builder
//
//  Created by Madsbook on 23.01.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

struct RampView: View {
    
    @ObservedObject var viewModel: RampViewModel
    
    init(viewModel: RampViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                GridView(step: self.viewModel.step(geometry.size))
                
                RampShape(startAngle: self.viewModel.startAngle, endAngle: self.viewModel.rampAngle, radius: self.viewModel.rampRadius, clockwise: false, scale: self.viewModel.scale(geometry.size))
                    .fill(Color.blue)
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
        .onAppear(perform: viewModel.refresh)
    }
}


struct RampView_Previews: PreviewProvider {
    static var previews: some View {
        RampView(viewModel: RampViewModel(gapParams: GapParams.defaultParams))
        .frame(width: 300, height: 150)
            .environment(\.colorScheme, .dark)
    }
}
