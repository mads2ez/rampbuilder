//
//  RampView.swift
//  Ramp Builder
//
//  Created by Madsbook on 23.01.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

struct RampView: View {
    
    @EnvironmentObject var viewModel: RampViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                GridView(step: self.viewModel.step(geometry.size))
                
                RampShape(startAngle: .degrees(0), endAngle: self.viewModel.rampangle, radius: self.viewModel.params?.radius ?? 0, clockwise: false, scale: self.viewModel.calcScale(width: geometry.size.width, height: geometry.size.height).scale)
                    .fill(Color.blue)
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}


struct RampView_Previews: PreviewProvider {
    static var previews: some View {
        RampView()
            .environmentObject(RampViewModel(params: GapParams.defaultParams))
        .frame(width: 300, height: 150)
            .environment(\.colorScheme, .dark)
    }
}
