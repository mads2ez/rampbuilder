//
//  GapView.swift
//  RampBuilder
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
        ZStack {
            Color("bg")
                .edgesIgnoringSafeArea(.all)
        
            ScrollView() {
                navBar()
                
                blueprintView()
                
                mainButtonView()
                
                takeoffCard2()
                
                landingCard2()
                
                gapCard()
//
                stiffnessCard()
            }
        }
            .foregroundColor(Color("primary"))
    }
}

extension GapView {
    func navBar() -> some View {
        return HStack {
            Text("Ramp Builder")
                .font(.system(size: 32, weight: .bold))
            
            Spacer()
            
//            Button(action: { self.viewModel.openInfoView() }, label: {
//                Image(systemName: "info")
//                })
//                .buttonStyle(RampCircleButtonStyle())
//                .sheet(isPresented: self.$viewModel.infoShown, onDismiss: self.viewModel.refresh, content: {
//                    self.viewModel.infoView
//                })
        }
        .padding(.horizontal)
        .padding(.leading, 14)
        .padding(.top, 56)
//        .padding(.bottom)
    }
    
    func blueprintView() -> some View {
        return ZStack {
            Rectangle()
                .fill(Color(UIColor.tertiarySystemBackground))
//                .fill(Color("bg"))
                .offset(x: 0, y: 10)
                .shadow(color: Color("shadow1"), radius: 5, x: -5, y: -5)
                .shadow(color: Color("shadow2"), radius: 5, x: 5, y: 5)
            
            BlueprintView(params: self.viewModel.gapParams)
                .padding(.all, 30)
                .frame(maxWidth: .infinity, minHeight: 300)
            
            }
                .offset(x: 0, y: -20)
    }
    
    func mainButtonView() -> some View {
        return Button(action: {
            self.viewModel.openEditor()
        }, label: {
            Text("Change dimensions")
//                .foregroundColor(Color.blue)
        })
            .buttonStyle(RampRoundedButtonStyle())
            .sheet(isPresented: self.$viewModel.inputShown, onDismiss: self.viewModel.refresh,
                   content: {
                    self.viewModel.inputView
            })
            .padding(.bottom, 10)
    }
    
    func takeoffCard() -> some View {
        return
            VStack(alignment: .leading) {
                Text("Takeoff")
                    .font(.system(size: 24, weight: .bold))
                
                HStack {
                    VStack {
                        Text("Height:")
                            .font(.caption)
                        Text("\(self.viewModel.gapParams.takeoff.height.toString(format: ".1")) m").font(.headline)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)

                    
                    Divider()
                    VStack {
                        Text("Length:").font(.caption)
                        Text("\(self.viewModel.gapParams.takeoffLength.toString(format: ".1")) m").font(.headline)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    
                }
                
                Divider()
                HStack {
                    VStack {
                        Text("Radius:").font(.caption)
                        Text("\(self.viewModel.gapParams.takeoffRadius.toString(format: ".1")) m").font(.headline)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)

                    
                    Divider()
                    
                    VStack {
                        Text("Angle:").font(.caption)
                        Text("\(self.viewModel.gapParams.takeoff.angle.toString(format: "."))°").font(.headline)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                }
            }
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
    }
    
    func landingCard() -> some View {
        return
            VStack(alignment: .leading) {
                Text("Landing")
                    .font(.system(size: 24, weight: .bold))
                
                HStack {
                    VStack {
                        Text("Height:")
                            .font(.caption)
                        Text("\(self.viewModel.gapParams.landing.height.toString(format: ".1")) m")
                            .font(.headline)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)

                    
                    Divider()
                    VStack {
                        Text("Length:").font(.caption)
                        Text("\(self.viewModel.gapParams.landingLength.toString(format: ".1")) m").font(.headline)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    
                }
                
                Divider()
                HStack {
                    VStack {
                        Text("Table:").font(.caption)
                        Text("\(self.viewModel.gapParams.landing.table.toString(format: ".1")) m").font(.headline)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)

                    
                    Divider()
                    
                    VStack {
                        Text("Angle:").font(.caption)
                        Text("\(self.viewModel.gapParams.landing.angle.toString(format: "."))°").font(.headline)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                }
            }
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
    }
    
    func gapCard() -> some View {
        return Section() {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Gap:")
                        Spacer()
                        Text(self.viewModel.formattedGap).font(.headline)
                    }
                    Divider()
                    
                    HStack {
                        Text("Speed:")
                        Spacer()
                        Text(self.viewModel.formattedSpeed).font(.headline)
                    }
                    
                    Divider()

                    HStack {
                        Text("Max Jump Height:")
                        Spacer()
                        Text(self.viewModel.formattedMaxHeight).font(.headline)
                    }
                    Divider()
                    
                }
                .padding(.horizontal)
                
        }
            .padding(.bottom, 20)
    }
    
    func stiffnessCard() -> some View {
        return Section {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Landing stiffness:")
                        Spacer()
                        
                        if self.viewModel.gapParams.landingStiffness.isNaN || self.viewModel.gapParams.landingStiffness == 0 {
                            Text("Undershoot").font(.headline)
                        } else {
                            Text(self.viewModel.formattedStiffness).font(.headline)
                        }
                    }
                    
                    Divider()
                    
                    Text("Stiffness is equivalent to the height of the drop on a flat landing")
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.caption)
//                        .foregroundColor(.secondary)
                }
        }
            .padding(.horizontal)
            .padding(.bottom, 30)
    }
}


extension GapView {
    fileprivate func takeoffCard2() -> some View {
        return Section {
            VStack {
                VStack(alignment: .leading) {
                    Text("Takeoff")
                        .font(.system(size: 24, weight: .bold))
                        .padding(.bottom, 20)
                    
                    HStack {
                        Text("Height:")
                        Spacer()
                        Text(self.viewModel.formattedTakeoffHeight).font(.headline)
                    }
                    Divider()
                    
                    HStack {
                        Text("Length:")
                        Spacer()
                        Text(self.viewModel.formattedTakeoffLength).font(.headline)
                    }
                    Divider()
                    
                    HStack {
                        Text("Angle:")
                        Spacer()
                        Text(self.viewModel.formattedTakeoffAngle).font(.headline)
                    }
                    Divider()
                    
                    HStack {
                        Text("Radius:")
                        Spacer()
                        Text(self.viewModel.formattedTakeoffRadius).font(.headline)
                    }
                    Divider()
                }
                .padding()

            }
        }
    }
    
    fileprivate func landingCard2() -> some View {
        return Section {
            VStack {
                VStack(alignment: .leading) {
                    Text("Landing")
                        .font(.system(size: 24, weight: .bold))
                        .padding(.bottom, 20)
                    
                    HStack {
                        Text("Height:")
                        Spacer()
                        Text(self.viewModel.formattedLandingHeight).font(.headline)
                    }
                    Divider()
                    
                    HStack {
                        Text("Length:")
                        Spacer()
                        Text(self.viewModel.formattedLandingLength).font(.headline)
                    }
                    Divider()
                    
                    HStack {
                        Text("Angle:")
                        Spacer()
                        Text(self.viewModel.formattedLandingAngle).font(.headline)
                    }
                    Divider()
                    
                    HStack {
                        Text("Table:")
                        Spacer()
                        Text(self.viewModel.formattedTable).font(.headline)
                    }
                    Divider()
                }
                .padding()
            }
        }
            .padding(.bottom, 20)
    }
}


struct GapView_Previews: PreviewProvider {
    static var previews: some View {
        GapView(viewModel: GapViewModel(params: GapParams.defaultParams)).environment(\.colorScheme, .light)
    }
}
