//
//  RampView.swift
//  Ramp Builder
//
//  Created by Madsbook on 23.01.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

struct RampView: View {
    
    @EnvironmentObject var ramp: GapCalculator
        
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                GridView(step: self.calcScale(width: geometry.size.width, height: geometry.size.height).step)
                
                RampShape(startAngle: .degrees(0), endAngle: .degrees(360 - self.ramp.takeoffAngle), radius: self.ramp.takeoffRadius, clockwise: false, scale: self.calcScale(width: geometry.size.width, height: geometry.size.height).scale)
                    .fill(Color.blue)
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
    
    
    func calcScale(width: CGFloat, height: CGFloat) -> (scale: Int, step: CGFloat) {
        let scale = Int(1 + self.ramp.takeoffLength)
        let step = width < height ? width / CGFloat(scale) : height / CGFloat(scale)
                
        return (scale: scale, step: step)
    }
}


struct RampView_Previews: PreviewProvider {
    static var previews: some View {
        RampView()
            .environmentObject(GapCalculator(height: 3, angle: 60))
        .frame(width: 300, height: 150)
            .environment(\.colorScheme, .dark)
    }
}
