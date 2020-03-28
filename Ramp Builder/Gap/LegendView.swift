//
//  LegendView.swift
//  Ramp Builder
//
//  Created by Madsbook on 23.01.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

struct LegendView: View {
    
    var gapParams: GapParams
    var backgroundColor: Color = Color(red: 0, green: 0, blue: 0, opacity: 0.2)
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text("Takeoff Height: \(gapParams.takeoff.height.toString(format: ".1")) m")
                Text("Takeoff Length: \(gapParams.takeoffLength.toString(format: ".1")) m")
                Text("Takeoff Radius: \(gapParams.takeoffRadius.toString(format: ".1")) m")
                Text("Takeoff Angle: \(gapParams.takeoff.angle.toString(format: "."))°")
            }
            
            
            VStack(alignment: .leading) {
                Text("Landing Height: \(gapParams.landing.height.toString(format: ".1")) m")
                Text("Landing Length: \(gapParams.landingLength.toString(format: ".1")) m")
                Text("Landing Angle: \(gapParams.landing.angle.toString(format: ".") )°")
                
                Text("")

                Text("Speed: \(gapParams.speed.toString(format: ".") ) m/s")
                Text("Gap: \(gapParams.gap.toString(format: ".1") ) m")
                
                Text("Landing stiffness (equal to height if you drop to flat landing): \((gapParams.landingStiffness.toString(format: ".1"))) m")
            }
        
        }
        .padding()
        .font(.caption)
        .background(backgroundColor)
    }
}

struct LegendView_Previews: PreviewProvider {
    static var previews: some View {
        LegendView(gapParams: GapParams.defaultParams)
            .frame(width: 350, height: 150)
    }
}
