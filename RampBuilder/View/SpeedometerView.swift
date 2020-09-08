//
//  SpeedometerView.swift
//  RampBuilder
//
//  Created by Madsbook on 08.06.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

struct SpeedometerView: View {
    var speed: Double
    
    var convertedSpeed: Measurement<UnitSpeed> {
        let speed = Measurement(value: self.speed < 0 ? 0 : self.speed, unit: UnitSpeed.metersPerSecond)
        return speed.converted(to: UnitSpeed.kilometersPerHour)
    }
    
    var value: String {
        let formatter = MeasurementFormatter()
        formatter.numberFormatter.maximumFractionDigits = 0
        return formatter.numberFormatter.string(from: NSNumber(value: convertedSpeed.value)) ?? "0"
    }
    
    var unit: String {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = [.providedUnit]
        formatter.unitStyle = .short
        return formatter.string(from: convertedSpeed.unit)
    }
    
    var progress: CGFloat {
        CGFloat(speed)
    }
    
    let colors = [Color(UIColor.systemBlue), Color(UIColor.systemIndigo),  Color(UIColor.systemIndigo)]
    
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    Circle()
                        .trim(from: 0, to: 0.75)
                        .rotation(.degrees(-45))
                        .stroke(Color.black.opacity(0.1), lineWidth: 50)
                    
                    Circle()
                        .trim(from: 0, to: self.setProgress())
                        .rotation(.degrees(-45))
                        .stroke(AngularGradient(gradient: .init(colors: self.colors), center: .center, angle: .init(degrees: -50)), lineWidth: 50)
                        .shadow(color: self.colors[0], radius: 5, x: 0, y: 0)
                }
                    .rotationEffect(.degrees(180))
            }
            
            VStack {
                Text(value)
                    .font(.system(size: 100, weight: .bold))
                Text(unit)
                    .font(.system(size: 18, weight: .bold))
            }
                .foregroundColor(Color("primary"))
        }
            .frame(width: 300, height: 300)
    }
    
    func setProgress() -> CGFloat {
        if self.convertedSpeed.value > 100 {
            return 0.75
        }
        
        let temp = self.progress * 0.75
        return temp * 0.01
    }
}

struct SpeedometerView_Previews: PreviewProvider {
    static var previews: some View {
        SpeedometerView(speed: 1)
    }
}
