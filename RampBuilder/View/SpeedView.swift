//
//  SpeedView.swift
//  RampBuilder
//
//  Created by Madsbook on 04.06.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

struct SpeedView: View {
    @ObservedObject var viewModel: SpeedViewModel
    @Binding var navBarHidden: Bool

    
    init(viewModel: SpeedViewModel, navBarHidden: Binding<Bool>) {
        UITableView.appearance().backgroundColor = UIColor(named: "bg")

        self.viewModel = viewModel
        self._navBarHidden = navBarHidden
    }
    
    var body: some View {
        ZStack {
            Color("bg")
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                SpeedometerView(speed: self.viewModel.speed)
                
                HStack {
                    Text("Max speed")
                    Text(String(self.viewModel.formattedMaxSpeed))
                }
                    .padding(.top, 50)
                    .foregroundColor(Color("primary"))
            }
        }
            .onAppear{
                self.viewModel.checkAuthorization()
                self.navBarHidden = false
            }
            .onDisappear(perform: viewModel.stopUpdating)
            .navigationBarBackButtonHidden(false)
            .navigationBarHidden(false)
    }
}

struct SpeedView_Previews: PreviewProvider {
    static var previews: some View {
        SpeedView(
            viewModel: SpeedViewModel(),
            navBarHidden: .constant(true)
        )
    }
}


// TODO
struct SpeedChart: View {
    var points: [Double]
    
    func step(range: CGFloat, count: Int) -> CGFloat {
        range / CGFloat(count)
    }
    
    func offset(index: Int, step: CGFloat) -> CGFloat {
        CGFloat(index) * step
    }
    
    func yOffset(value: Double, step: CGFloat, height: CGFloat) -> CGFloat {
        height - CGFloat(value) * step
    }
        
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                
                path.move(to: CGPoint(x: 0, y:0))
                for i in 0..<self.points.count {
                    let xStep = self.step(range: geometry.size.width, count: 50)
                    let yStep = self.step(range: geometry.size.height, count: 100)
                    
                    let x = self.offset(index: i, step: xStep)
                    let y = self.yOffset(value: self.points[i], step: yStep, height: geometry.size.height)
                    
                    path.addLine(to: CGPoint(x: x, y: y))
                }
            }
                .stroke(Color("accent"), lineWidth: 0.5)
        }
    }
}
