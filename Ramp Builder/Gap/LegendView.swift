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
        
        VStack {
            Section(header: Text("Takeoff")) {
                Text("Height: \(gapParams.takeoff.height.toString(format: ".1")) m")
                Text("Length: \(gapParams.takeoffLength.toString(format: ".1")) m")
                Text("Radius: \(gapParams.takeoffRadius.toString(format: ".1")) m")
                Text("Angle: \(gapParams.takeoff.angle.toString(format: "."))°")
            }
            
            Section(header: Text("Landing")) {
                Text("Height: \(gapParams.landing.height.toString(format: ".1")) m")
                Text("Length: \(gapParams.landingLength.toString(format: ".1")) m")
                Text("Angle: \(gapParams.landing.angle.toString(format: ".") )°")
            }
            
            Section(header: Text("Stuff")) {
                Text("Gap: \(gapParams.gap.toString(format: ".1") ) m")
                Text("Speed: \(gapParams.speed.toString(format: ".") ) m/s")
                Text("Landing stiffness (equal to height if you drop to flat landing): \((gapParams.landingStiffness.toString(format: ".1"))) m")
                Text("Max Height: \((gapParams.maxHeight.toString(format: ".1"))) m")
            }
        }
    }
}

struct LegendView_Previews: PreviewProvider {
    static var previews: some View {
        LegendView(gapParams: GapParams.defaultParams)
            .frame(width: 350, height: 150)
    }
}
