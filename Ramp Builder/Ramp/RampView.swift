//
//  RampView.swift
//  Ramp Builder
//
//  Created by Madsbook on 23.01.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

struct RampView: View {
    
    @EnvironmentObject var ramp: GapParamsViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                GridView(step: self.ramp.calcScale(width: geometry.size.width, height: geometry.size.height).step)
                
                RampShape(startAngle: .degrees(0), endAngle: self.ramp.rampangle, radius: self.ramp.params?.radius ?? 0, clockwise: false, scale: self.ramp.calcScale(width: geometry.size.width, height: geometry.size.height).scale)
                    .fill(Color.blue)
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}


struct RampView_Previews: PreviewProvider {
    static var previews: some View {
        RampView()
            .environmentObject(GapParamsViewModel(params: GapParams.defaultParams))
        .frame(width: 300, height: 150)
            .environment(\.colorScheme, .dark)
    }
}
