//
//  InputView.swift
//  Ramp Builder
//
//  Created by Madsbook on 23.01.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

struct InputView: View {
    @ObservedObject var viewModel: InputViewModel
    
    init(viewModel: InputViewModel) {
        self.viewModel = viewModel
        UITableView.appearance().backgroundColor = .clear
    }
        
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    RampTextFieldView(title: "Takeoff Height", placeholder: "Meters", value: self.$viewModel.takeoffHeight)
                    
                    RampPickerRow(title: "Takeoff Angle", value: $viewModel.takeoffAngle)
                        .onTapGesture {
                            withAnimation {
                                self.viewModel.takeoffPickerIsShown.toggle()
                            }
                        }
                    
                    if viewModel.takeoffPickerIsShown {
                        RampPickerView(index: self.$viewModel.takeoffAngle, values: viewModel.possibleAngleRange)
                    }
                    
                    RampTextFieldView(title: "Gap distance", placeholder: "Meters", value: self.$viewModel.gap)
                    
                    RampTextFieldView(title: "Table", placeholder: "Meters", value: self.$viewModel.table)
                    
                    RampTextFieldView(title: "Landing Height", placeholder: "Meters", value: self.$viewModel.landingHeight)
                    
                    RampPickerRow(title: "Landing Angle", value: $viewModel.landingAngle)
                        .onTapGesture {
                            withAnimation {
                                self.viewModel.landingPickerIsShown.toggle()
                            }
                        }
                    
                    if viewModel.landingPickerIsShown {
                        RampPickerView(index: self.$viewModel.landingAngle, values: viewModel.possibleAngleRange)
                    }
                    
                    RampTextFieldView(title: "Speed", placeholder: "m/s", value: self.$viewModel.speed)
                }
                .padding(.bottom, 50)
            
                Button(action: {
                    self.viewModel.saveInput()
                }, label: {
                    Text("Calculate Jump")
                }).disabled(self.viewModel.isValid == false)
                    .buttonStyle(RampButtonStyle())
                
                Spacer()
            } //vstack
                .padding(.vertical)
        } //scrollview
            .onTapGesture {
                 UIApplication.shared.endEditing()
             }
    }
}


struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
//            GapView(viewModel: GapViewModel(params: GapParams.defaultParams))
            InputView(viewModel: InputViewModel(params: GapParams.defaultParams))
        }
    }
}

