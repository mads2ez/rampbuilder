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
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    init(viewModel: InputViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            Form {
                HStack {
                    Text("Takeoff Height")
                    TextField("Meters", text: self.$viewModel.takeoffHeight)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                }

                HStack {
                    Text("Takeoff Angle")
                    
                    Spacer()
                    
                    Text("\(self.viewModel.takeoffAngle)°")

                }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        self.viewModel.takeoffPickerIsShown.toggle()
                    }

                if viewModel.takeoffPickerIsShown {
                   GapPickerView(index: self.$viewModel.takeoffAngle, values: viewModel.possibleAngleRange)
                }

                HStack {
                    Text("Gap distance")
                    TextField("Meters", text: self.$viewModel.gap)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                }

                HStack {
                    Text("Table")
                    TextField("Meters", text: self.$viewModel.table)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                }

                HStack {
                    Text("Landing Height")
                    TextField("Meters", text: self.$viewModel.landingHeight)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                }

                HStack {
                    Text("Landing Angle")
                    
                    Spacer()
                    
                    Text("\(self.viewModel.landingAngle)°")
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        self.viewModel.landingPickerIsShown.toggle()
                    }

                if viewModel.landingPickerIsShown {
                    GapPickerView(index: self.$viewModel.landingAngle, values: viewModel.possibleAngleRange)
                }
               
                HStack {
                    Text("Speed")
                    TextField("m/s", text: self.$viewModel.speed)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                }
                
           }
                .edgesIgnoringSafeArea(.bottom)
                .onTapGesture {
                    UIApplication.shared.endEditing()
                }
                .navigationBarTitle("Jump Calculator", displayMode: .inline)
                .navigationBarItems(
                    leading:
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Cancel")
                    }),
                    trailing:
                    Button(action: {
                        self.viewModel.saveInput()
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Done")
                            .fontWeight(.bold)
                            .foregroundColor(viewModel.isValid ? Color.blue : Color.gray)
                        }).disabled(!viewModel.isValid)
                )
        }
    }
}


struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            InputView(viewModel: InputViewModel(params: GapParams.defaultParams))
        }
    }
}
