//
//  GapInputView.swift
//  Ramp Builder
//
//  Created by Madsbook on 23.01.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

struct InputView: View {
    @EnvironmentObject var jump: GapCalculator
    @EnvironmentObject var data: UserData
   
    var isValid: Bool {
        if (data.gap.isEmpty || data.table.isEmpty || data.takeoffHeight.isEmpty || data.landingHeight.isEmpty || data.speed.isEmpty) {
            return false
        }
        return true
    }
    
    
    var body: some View {
        VStack {
            
            VStack {
                RampTextFieldView(title: "Takeoff Height", placeholder: "Meters", value: self.$data.takeoffHeight).padding(.bottom, 10)
                
                RampPickerCellView(title: "Takeoff Angle", value: self.$data.takeoffAngle).padding(.bottom, 10)
                
                RampTextFieldView(title: "Gap distance", placeholder: "Meters", value: self.$data.gap).padding(.bottom, 10)
                
                RampTextFieldView(title: "Table", placeholder: "Meters", value: self.$data.table).padding(.bottom, 10)
                
                RampTextFieldView(title: "Landing Height", placeholder: "Meters", value: self.$data.landingHeight).padding(.bottom, 10)
                
                RampPickerCellView(title: "Landing Angle", value: self.$data.landingAngle).padding(.bottom, 10)
                
                RampTextFieldView(title: "Speed", placeholder: "m/s", value: self.$data.speed).padding(.bottom, 10)
            }
            .padding()
            
            HStack {
                Spacer()

                Button(action: {
                    self.jump.gap = Double(self.data.gap.replaceComma()) ?? 0
                    self.jump.table = Double(self.data.table.replaceComma()) ?? 0
                    self.jump.takeoffHeight = Double(self.data.takeoffHeight.replaceComma()) ?? 0
                    self.jump.takeoffAngle = Double( self.data.takeoffAngle)
                    self.jump.landingHeight = Double(self.data.landingHeight.replaceComma()) ?? 0
                    self.jump.landingAngle = Double(self.data.landingAngle)
                    self.jump.speed = Double(self.data.speed.replaceComma()) ?? 0

                    self.endEditing()

                    print("height \(self.jump.takeoffHeight), angle \(self.jump.takeoffAngle), radius \(self.jump.takeoffRadius), length \(self.jump.takeoffLength), land length \(self.jump.landingLength), land height \(self.jump.landingHeight ?? 0), land angle \(self.jump.landingAngle ?? 0)")
                }, label: {
                    Text("Calculate Jump")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .accentColor(Color.white)
                        .background(isValid ? Color.blue : Color.gray)
                        .cornerRadius(15)
                        .padding(.horizontal, 20)
                }).disabled(self.isValid == false)

                Spacer()
            }
            
        }
            .onTapGesture {
                self.endEditing()
            }
    }
        
    func endEditing() {
        UIApplication.shared.endEditing()
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView()
            .environmentObject(GapCalculator())
            .environmentObject(UserData(GapCalculator()))
    }
}

