//
//  GapView.swift
//  Ramp Builder
//
//  Created by Madsbook on 23.01.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

struct GapView: View {

    @ObservedObject var viewModel: GapViewModel
    
    init(viewModel: GapViewModel) {
        self.viewModel = viewModel
    }
        
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    GridView(step: self.viewModel.step(geometry.size), color: Color.gray)
                    
                    GapShape(gapParams: self.viewModel.gapParams)
                        .stroke(Color.blue, lineWidth: 2)
                    
                    Trajectory(gapParams:  self.viewModel.gapParams)
                        .stroke(Color.green, lineWidth: 2)
                }
                .frame(width: geometry.size.width, height: geometry.size.width/2)
                    .padding()
                
                LegendView(viewModel: LegendViewModel(params: self.viewModel.gapParams, color: Color.white))
                .frame(width: geometry.size.width, height: geometry.size.width/2)

            }
        }
        .onAppear(perform: viewModel.refresh)
    }
}

struct GapView_Previews: PreviewProvider {
    static var previews: some View {
        GapView(viewModel: GapViewModel(params: GapParams.defaultParams))
    }
}
