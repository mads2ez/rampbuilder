//
//  InputView.swift
//  RampBuilder
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
        
//        UITableView.appearance().backgroundColor = UIColor(named: "bg")
    }
    
    var body: some View {
        NavigationView {
            VStack {

            Form {
                Section(header: Text("Takeoff")) {
                    HStack {
                        Text("Height")
                            .frame(width: UIScreen.main.bounds.width/4, alignment: .leading)
                        Divider()
                        TextField("Meters", text: self.$viewModel.takeoffHeight)
                            .keyboardType(.decimalPad)
                    }
                    
                    HStack {
                        Text("Angle")
                        .frame(width: UIScreen.main.bounds.width/4, alignment: .leading)
                        Divider()
                        
                        Text("\(self.viewModel.takeoffAngle)°")
                        Spacer()
                    }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            self.viewModel.takeoffPickerIsShown.toggle()
                        }

                    if viewModel.takeoffPickerIsShown {
                       GapPickerView(index: self.$viewModel.takeoffAngle, values: viewModel.possibleAngleRange)
                    }
                }
                
                Section {
                    HStack {
                        Text("Gap")
                        .frame(width: UIScreen.main.bounds.width/4, alignment: .leading)
                        Divider()
                        TextField("Meters", text: self.$viewModel.gap)
                            .keyboardType(.decimalPad)
                    }
                    
                    HStack {
                        Text("Speed")
                        .frame(width: UIScreen.main.bounds.width/4, alignment: .leading)
                        Divider()
                        TextField("km/h", text: self.$viewModel.speed)
                            .keyboardType(.decimalPad)
                    }
                }
                
                Section(header: Text("Landing")) {
                    HStack {
                        Text("Table")
                        .frame(width: UIScreen.main.bounds.width/4, alignment: .leading)
                        Divider()
                        TextField("Meters", text: self.$viewModel.table)
                            .keyboardType(.decimalPad)
                    }

                    HStack {
                        Text("Height")
                        .frame(width: UIScreen.main.bounds.width/4, alignment: .leading)
                        Divider()
                        TextField("Meters", text: self.$viewModel.landingHeight)
                            .keyboardType(.decimalPad)
                    }

                    HStack {
                        Text("Angle")
                            .frame(width: UIScreen.main.bounds.width/4, alignment: .leading)
                        Divider()
                        Text("\(self.viewModel.landingAngle)°")
                        Spacer()
                    }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            self.viewModel.landingPickerIsShown.toggle()
                        }

                    if viewModel.landingPickerIsShown {
                        GapPickerView(index: self.$viewModel.landingAngle, values: viewModel.possibleAngleRange)
                    }
                }
                }
                
            HStack {
                Button(action: {
                    self.viewModel.saveInput()
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Done")
                        .frame(maxWidth: .infinity)
                })
                    .buttonStyle(RampRoundedButtonStyle())
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                    .disabled(!self.viewModel.isValid)
            }
                
            }
                .background(Color("bg"))
                .edgesIgnoringSafeArea(.bottom)
                .onTapGesture {
                    UIApplication.shared.endEditing()
                }
                .navigationBarTitle("Dimensions", displayMode: .inline)
                .navigationBarItems(
                    leading:
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Cancel")
                    }))
        }
    }
}


struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            InputView(viewModel: InputViewModel(params: GapParams.defaultParams)).environment(\.colorScheme, .light)
        }
    }
}
