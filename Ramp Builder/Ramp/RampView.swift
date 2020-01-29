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
                GridView(step: self.calcScale(width: geometry.size.width, height: geometry.size.height).step)
                
                RampShape(startAngle: .degrees(0), endAngle: .degrees(360 - (self.ramp.params?.takeoff.angle ?? 0)), radius: self.ramp.params?.takeoff.radius ?? 0, clockwise: false, scale: self.calcScale(width: geometry.size.width, height: geometry.size.height).scale)
                    .fill(Color.blue)
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
    
    
    func calcScale(width: CGFloat, height: CGFloat) -> (scale: Int, step: CGFloat) {
        let scale = Int(1 + (self.ramp.params?.takeoff.length ?? 0))
        let step = width < height ? width / CGFloat(scale) : height / CGFloat(scale)
                
        return (scale: scale, step: step)
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
