//
//  SpeedView.swift
//  RampBuilder
//
//  Created by Madsbook on 04.06.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

struct SpeedView: View {
    @ObservedObject var viewModel = SpeedViewModel()
    
    @Binding var navBarHidden: Bool
    
    var body: some View {
        ZStack {
            Color("bg")
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                SpeedometerView(speed: self.$viewModel.speed)
                
                HStack {
                    Text("Max Speed")
                    Text(String(self.viewModel.formattedMaxSpeed))
                    
                    // TODO: distance
                }
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
        SpeedView(navBarHidden: .constant(true))
    }
}
