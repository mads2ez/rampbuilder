//
//  SpeedometerView.swift
//  RampBuilder
//
//  Created by Madsbook on 08.06.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

struct SpeedometerView: View {
    @Binding var speed: Double
    
    let formatter = MeasurementFormatter()
    
    var convertedSpeed: Measurement<UnitSpeed> {
        let speed = Measurement(value: self.speed < 0 ? 0 : self.speed, unit: UnitSpeed.metersPerSecond)
        return speed.converted(to: UnitSpeed.kilometersPerHour)
    }
    
    var value: String {
        formatter.numberFormatter.maximumFractionDigits = 0
        return formatter.numberFormatter.string(from: NSNumber(value: convertedSpeed.value)) ?? "0"
    }
    
    var unit: String {
        formatter.unitOptions = [.providedUnit]
        formatter.unitStyle = .short
        return formatter.string(from: convertedSpeed.unit)
    }
    
    var progress: CGFloat {
        CGFloat(speed)
    }
    
    let colors = [Color(UIColor.systemIndigo), Color(UIColor.systemTeal),  Color(UIColor.systemTeal)]
    
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    Circle()
                        .trim(from: 0, to: 0.5)
                        .stroke(Color.black.opacity(0.1), lineWidth: 50)
                    
                    Circle()
                        .trim(from: 0, to: self.setProgress())
                        .stroke(AngularGradient(gradient: .init(colors: self.colors), center: .center, angle: .init(degrees: -50)), lineWidth: 50)
                        .shadow(color: self.colors[0], radius: 5, x: 0, y: 0)
                }
                    .rotationEffect(.degrees(180))
                
                HStack {
                    Text("0")
                        .foregroundColor(self.colors[0])
                    Spacer()
                    Text("100")
                        .foregroundColor(self.colors[0])
                }
                .font(.system(size: 10, weight: .bold))
                .offset(y: -140)
            }
            
            
            VStack {
                Text(unit)
                Text(value)
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(self.colors[0])
            }
                .offset(y: -35)
        }
            .frame(width: 300, height: 300)
    }
    
    func setProgress()->CGFloat{
        
        let temp = self.progress / 2
        return temp * 0.01
    }
}

//struct SpeedometerView_Previews: PreviewProvider {
//    static var previews: some View {
////        SpeedometerView()
//    }
//}
