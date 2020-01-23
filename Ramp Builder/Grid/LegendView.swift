//
//  LegendView.swift
//  Ramp Builder
//
//  Created by Madsbook on 23.01.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

struct LegendView: View {
    var jump: GapCalculator
    var backgroundColor = Color(red: 0, green: 0, blue: 0, opacity: 0.2)
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text("Takeoff Height: \(jump.takeoffHeight.toString(format: ".1")) m")
                Text("Takeoff Length: \(jump.takeoffLength.toString(format: ".1")) m")
                Text("Takeoff Radius: \(jump.takeoffRadius.toString(format: ".1")) m")
                Text("Takeoff Angle: \(jump.takeoffAngle.toString(format: "."))°")
            }
            
            if jump.gap != nil {
                VStack(alignment: .leading) {
                    Text("Landing Height: \(jump.landingHeight?.toString(format: ".1") ?? "0") m")
                    Text("Landing Length: \(jump.landingLength.toString(format: ".1")) m")
                    Text("Landing Angle: \(jump.landingAngle?.toString(format: ".") ?? "0")°")
                    
                    Text("")

                    Text("Speed: \(jump.speed?.toString(format: ".") ?? "0") m/s")
                    Text("Gap: \(jump.gap?.toString(format: ".1") ?? "0") m")
                    
                    Text("Landing stiffness (equal to height if you drop to flat landing): \(jump.findRoot().toString(format: ".1")) m")
                }
            }
        }
        .padding()
        .font(.caption)
        .background(self.backgroundColor)
    }
}

struct LegendView_Previews: PreviewProvider {
    static var previews: some View {
        LegendView(jump: GapCalculator(height: 2, angle: 60))
            .frame(width: 350, height: 150)
    }
}
