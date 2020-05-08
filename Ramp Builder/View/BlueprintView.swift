//
//  BlueprintView.swift
//  Ramp Builder
//
//  Created by Madsbook on 12.04.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

struct BlueprintView: View {
    var offset: CGFloat = 20

    var params: GapParams
    var gridColor = Color.gray
    
    var body: some View {
        GeometryReader { geometry in
            // grid
            ForEach(0..<Int(geometry.size.height / self.calcStep(geometry.size)), id: \.self) { line in
                Group {
                    Path { path in
                        let y = self.yOffset(Double(line), size: geometry.size)

                        path.move(to: CGPoint(x: 0, y: y))
                        path.addLine(to: CGPoint(x: geometry.size.width, y: y))
                    }
                        .stroke(self.gridColor, lineWidth: 0.5)
                    if line > 0 {
                        Text("\(line)")
                        .font(.caption)
                        .foregroundColor(Color.gray)
                        .offset(x: 5, y: self.yOffset(Double(line), size: geometry.size))
                    }
                }
            } //foreach

            ForEach(0..<Int(geometry.size.width / self.calcStep(geometry.size)), id: \.self) { line in
                Group {
                    Path { path in
                        let x = self.xOffset(Double(line), size: geometry.size)

                        path.move(to: CGPoint(x: x, y: geometry.size.height))
                        path.addLine(to: CGPoint(x: x, y: 0))
                    }
                        .stroke(self.gridColor, lineWidth: 0.5)
                    if line > 0 {
                        Text("\(line)")
                            .font(.caption)
                            .foregroundColor(Color.gray)
                            .offset(x: self.xOffset(Double(line), size: geometry.size), y: geometry.size.height + 5)
                    }
                }
            } //foreach
            
            // gap
            Path { path in
                let step = self.calcStep(geometry.size)
                
                let rotationAdjustment = Angle.degrees(270)
                let modifiedStart = Angle.degrees(0) - rotationAdjustment
                let modifiedEnd = Angle.degrees(360-self.params.takeoff.angle) - rotationAdjustment
                let modifiedRadius = CGFloat(self.params.takeoffRadius) * step
                
                let radiusCenter = CGPoint(x: 0, y: geometry.size.height - modifiedRadius)
                let takeoffEndPoint = CGPoint(x: modifiedRadius * CGFloat(cos(modifiedEnd.radians)), y: geometry.size.height)
                let gapPoint = CGPoint(x: CGFloat(self.params.takeoffLength) * step + CGFloat(self.params.gap) * step - (CGFloat(self.params.landing.table) * step), y: geometry.size.height)
                let landingStartPoint = CGPoint(x: modifiedRadius * CGFloat(cos(modifiedEnd.radians)) + (CGFloat(self.params.gap) * step) - (CGFloat(self.params.landing.table) * step), y: geometry.size.height - (CGFloat(self.params.landing.height) * step))
                let tablePoint = CGPoint(x: modifiedRadius * CGFloat(cos(modifiedEnd.radians)) + (CGFloat(self.params.gap) * step), y: geometry.size.height - (CGFloat(self.params.landing.height) * step))
                let landingPoint1 = CGPoint(x: modifiedRadius * CGFloat(cos(modifiedEnd.radians)) + (CGFloat(self.params.gap) * step), y:
                geometry.size.height - (CGFloat(self.params.landing.height) * step))
                let landingPoint2 = CGPoint(x: modifiedRadius * CGFloat(cos(modifiedEnd.radians)) + (CGFloat(self.params.gap) * step) + (CGFloat(self.params.landingLength) * step), y: geometry.size.height)
                
                print("number of lines: \(self.maxDimension)")
                // Takeoff
                path.addArc(center: radiusCenter, radius: modifiedRadius, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: true)
                
                // x = a + r cos t
                // y = b + r sin t
                path.addLine(to: takeoffEndPoint)
                
                // Gap
                path.move(to: gapPoint)
                
                // Landing
                path.addLine(to: landingStartPoint)
                
                // Table
                if self.params.landing.table != 0 {
                    path.addLine(to: tablePoint)
                }
                path.addLine(to: landingPoint1)
                path.addLine(to: landingPoint2)
            }
                .stroke(Color.blue, lineWidth: 4)

            // trajectory
            Path { path in
                let startPont = self.startPoint(geometry.size)
                let trajectoryPoints = self.trajectoryPoints(geometry.size)
                
                path.move(to: startPont)
                path.addLines(trajectoryPoints)
                
            }
                .stroke(Color.green, style: StrokeStyle(lineWidth: 2, dash: [10]))
        }
    }
}

extension BlueprintView {
    func calcStep(_ size: CGSize) -> CGFloat {
        let step = size.width > size.height ? size.width / CGFloat(maxDimension) : size.height / CGFloat(maxDimension)

        return step
//            return self.yHeight(size.height, count: self.maxDimension)
//            return self.xWidth($0.height, count: self.maxDimension)
    }
    
    var maxDimension: Int {
        let maxlength = self.params.takeoffLength + self.params.gap + self.params.landingLength
        let maxHeight = self.params.maxHeight
    
//        if max(maxHeight, maxlength) <= 5 {
//            return 5
//        }
//
//        if max(maxHeight, maxlength) <= 10 {
//            return 10
//        }
        return Int(max(maxHeight, maxlength)) + 1
    }
    
    func xWidth(_ width: CGFloat, count: Int) -> CGFloat {
        width / CGFloat(count)
    }

    func yHeight(_ height: CGFloat, count: Int) -> CGFloat {
        height / CGFloat(count)
    }

    func xOffset(_ line: Double, size: CGSize) -> CGFloat {
        CGFloat(line) * calcStep(size)
    }

    func yOffset(_ line: Double, size: CGSize) -> CGFloat {
        size.height - CGFloat(line) * calcStep(size)
    }

    var startPoint: (_ size: CGSize) -> CGPoint {
        return {
            return CGPoint(x: CGFloat(self.params.takeoffLength) * self.calcStep($0), y: $0.height - CGFloat(self.params.takeoff.height) * self.calcStep($0))
        }
    }

    var trajectoryPoints: (_ size: CGSize) -> [CGPoint] {
        return {
            let x = self.getXArray(size: $0)
            var result: [CGPoint] = []
            
            for i in x {

                let y = self.calcParabola(x: i)
                
                if  Double($0.height) - y * Double(self.calcStep($0)) - self.params.takeoff.height * Double(self.calcStep($0)) <= Double($0.height) && i * Double(self.calcStep($0)) + Double(self.startPoint($0).x) <= Double($0.width) {
                    
                    result.append(CGPoint(x: i * Double(self.calcStep($0)) + Double(self.startPoint($0).x), y: Double($0.height) - y * Double(self.calcStep($0)) - self.params.takeoff.height * Double(self.calcStep($0)) ))
                }
            }
            return result
        }
    }

    func calcParabola(x: Double) -> Double {
        let result = (x * tan(self.params.takeoff.angle * .pi / 180)) - (9.8 * pow(x, 2) / (2 * pow(self.params.speed * 0.28, 2) * pow(cos(self.params.takeoff.angle * .pi / 180), 2)))
         
        return Double(result)
    }

    func getXArray(size: CGSize) -> [Double] {
        return Array(0...Int(size.width * 10)).map{Double($0) / 10}
    }
    
    

}


struct BlueprintView_Previews: PreviewProvider {
    static var previews: some View {
        BlueprintView(params: GapParams.defaultParams).environment(\.colorScheme, .dark)
    }
}
