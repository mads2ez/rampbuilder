//
//  LegendView.swift
//  Ramp Builder
//
//  Created by Madsbook on 23.01.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

struct LegendView: View {
    var viewModel: LegendViewModel

    init(viewModel: LegendViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text("Takeoff Height: \(viewModel.gapParams.takeoff.height.toString(format: ".1")) m")
                Text("Takeoff Length: \(viewModel.takeoffLength.toString(format: ".1")) m")
                Text("Takeoff Radius: \(viewModel.takeoffRadius.toString(format: ".1")) m")
                Text("Takeoff Angle: \(viewModel.gapParams.takeoff.angle.toString(format: "."))°")
            }
            
            if viewModel.gapParams.gap != nil {
                VStack(alignment: .leading) {
                    Text("Landing Height: \(viewModel.gapParams.landing.height.toString(format: ".1")) m")
                    Text("Landing Length: \(viewModel.landingLength.toString(format: ".1")) m")
                    Text("Landing Angle: \(viewModel.gapParams.landing.angle.toString(format: ".") )°")
                    
                    Text("")

                    Text("Speed: \(viewModel.gapParams.speed.toString(format: ".") ) m/s")
                    Text("Gap: \(viewModel.gapParams.gap.toString(format: ".1") ) m")
                    
                    Text("Landing stiffness (equal to height if you drop to flat landing): \((viewModel.stiffness.toString(format: ".1"))) m")
                }
            }
        }
        .padding()
        .font(.caption)
        .background(viewModel.backgroundColor)
    }
}

struct LegendView_Previews: PreviewProvider {
    static var previews: some View {
        LegendView(viewModel: LegendViewModel(params: GapParams.defaultParams))
            .frame(width: 350, height: 150)
    }
}
