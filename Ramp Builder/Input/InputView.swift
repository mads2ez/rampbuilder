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
    }
    
    var body: some View {
        ScrollView() {
            VStack {
                
                VStack {
                    RampTextFieldView(title: "Takeoff Height", placeholder: "Meters", value: self.$viewModel.takeoffHeight).padding(.bottom, 10)
                    
                    RampPickerView(title: "Takeoff Angle", value: self.$viewModel.takeoffAngle).padding(.bottom, 10)
                    
                    RampTextFieldView(title: "Gap distance", placeholder: "Meters", value: self.$viewModel.gap).padding(.bottom, 10)
                    
                    RampTextFieldView(title: "Table", placeholder: "Meters", value: self.$viewModel.table).padding(.bottom, 10)
                    
                    RampTextFieldView(title: "Landing Height", placeholder: "Meters", value: self.$viewModel.landingHeight).padding(.bottom, 10)
                    
                    RampPickerView(title: "Landing Angle", value: self.$viewModel.landingAngle).padding(.bottom, 10)
                    
                    RampTextFieldView(title: "Speed", placeholder: "m/s", value: self.$viewModel.speed).padding(.bottom, 10)
                }
                .padding()
                
                HStack {
                    Spacer()

                    Button(action: {
                        self.viewModel.saveInput()
                        UIApplication.shared.endEditing()
                    }, label: {
                        Text("Calculate Jump")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .accentColor(Color.white)
                            .background(self.viewModel.isValid ? Color.blue : Color.gray)
                            .cornerRadius(15)
                            .padding(.horizontal, 20)
                    }).disabled(self.viewModel.isValid == false)

                    Spacer()
                }
                
            }
        }
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(viewModel: InputViewModel(params: GapParams.defaultParams))
    }
}

