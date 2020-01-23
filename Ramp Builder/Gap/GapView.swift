//
//  GapView.swift
//  Ramp Builder
//
//  Created by Madsbook on 23.01.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

struct GapView: View {
    @EnvironmentObject var jump: GapCalculator
        
    var body: some View {
        GeometryReader { geometry in
            GridView(step: self.calcScale(width: geometry.size.width, height: geometry.size.height).step, color: Color.gray)
            
            GapShape(jump: self.jump, scale: self.calcScale(width: geometry.size.width, height: geometry.size.height).scale)
                .stroke(Color.blue, lineWidth: 2)
                .frame(width: geometry.size.width, height: geometry.size.height)
            
            Trajectory(jump: self.jump, step: self.calcScale(width: geometry.size.width, height: geometry.size.height).step)
                .stroke(Color.green, lineWidth: 2)
            
            LegendView(jump: self.jump)
        }
    }
    
    func calcScale(width: CGFloat, height: CGFloat) -> (scale: Int, step: CGFloat) {
        let ramplength = 1 + self.jump.takeoffLength + (self.jump.gap ?? 0)
        let landlength = self.jump.landingLength
        let scale = Int(ramplength + landlength)
        
        let step = width / CGFloat(scale)
                
        return (scale: scale, step: step)
    }
}

struct GapView_Previews: PreviewProvider {
    static var previews: some View {
        GapView()
            .environmentObject(GapCalculator(gap: 2, table: 1, takeoffHeight: 2, takeoffAngle: 60, landingHeight: 2, landingAngle: 30, speed: 20))
            .frame(width: 300, height: 150)
    }
}
