//
//  AngleView.swift
//  RampBuilder
//
//  Created by Madsbook on 03.06.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

struct AngleView: View {
    
    @ObservedObject var viewModel = AngleViewModel()
    @Binding var navBarHidden: Bool

    var body: some View {
        ZStack {
            Color("bg")
                .edgesIgnoringSafeArea(.all)
                
            Text(viewModel.angle + "°")
                .font(.system(size: 48, weight: .light))
        }
            .onAppear{
                self.viewModel.perform()
                self.navBarHidden = false
            }
    }
}

struct AngleView_Previews: PreviewProvider {
    static var previews: some View {
        AngleView(navBarHidden: .constant(false))
    }
}
