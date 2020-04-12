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
    
    @State var inputShown: Bool = false
    
    init(viewModel: GapViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                blueprintView()
                    .frame(minHeight: 220)
                    .listRowInsets(EdgeInsets())
                    .background(Color.white)
                    .padding(.bottom, 20)
                                
                takeoffCard()
                
                landingCard()
                
                gapCard()

                stiffnessCard()
            }
                .background(Color(UIColor.systemGray6))
                .edgesIgnoringSafeArea(.bottom)
//                .onAppear(perform: viewModel.refresh)
                .sheet(isPresented: $inputShown, onDismiss: viewModel.refresh,
                       content: {
                        self.viewModel.inputView
                        })
                .navigationBarTitle("Ramp Builder", displayMode: .inline)
                .navigationBarItems(trailing:
                    Button(action: {
                        self.inputShown = true
                    }, label: {
                        Text("Edit")
                    }))
        }
    }
}


extension GapView {
   fileprivate func blueprintView() -> some View {
        return GeometryReader { geometry in
            ZStack {
                GridView(step: self.viewModel.step(geometry.size), color: Color.gray)
                
                GapShape(gapParams: self.viewModel.gapParams)
                    .stroke(Color.blue, lineWidth: 2)
                
                Trajectory(gapParams:  self.viewModel.gapParams)
                    .stroke(Color.green, lineWidth: 2)
                
//                TrajectoryShape(startPoint: self.viewModel.startPoint(CGSize(width: geometry.size.width, height: geometry.size.height/3)), data: self.viewModel.trajectoryPoints(CGSize(width: geometry.size.width, height: geometry.size.height/3)))
//                    .stroke(Color.yellow, lineWidth: 2)
            }
            .background(Color.white)
            .padding()
        }
    }
    
    func takeoffCard() -> some View {
        return Section(header: Header(title: "Takeoff")) {
            Card {
                VStack {
                    HStack {
                        VStack {
                            Text("Height:").font(.caption)
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
            }
        }
    }
    
    func landingCard() -> some View {
        return Section(header: Header(title: "Landing")) {
            Card {
                VStack {
                    HStack {
                        VStack {
                            Text("Height:").font(.caption)
                            Text("\(self.viewModel.gapParams.landing.height.toString(format: ".1")) m").font(.headline)
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
            }
        }
    }
    
    func gapCard() -> some View {
        return Section() {
            Card {
                VStack(alignment: .leading) {
                    Text("Gap: \(self.viewModel.gapParams.gap.toString(format: ".1") ) m")
                    Divider()
                    Text("Speed: \(self.viewModel.gapParams.speed.toString(format: ".") ) m/s")
                    Divider()

                    Text("Max Jump Height: \((self.viewModel.gapParams.maxHeight.toString(format: ".1"))) m")
                }
            }
        }
    }
    
    func stiffnessCard() -> some View {
        return Section {
            Card {
                VStack(alignment: .leading) {
                    Text("Landing stiffness: \((self.viewModel.gapParams.landingStiffness.toString(format: ".1"))) m").fixedSize(horizontal: false, vertical: true)

                    Divider()
                    
                    Text("Stiffness is equivalent to the height of the drop on a flat landing")
                        .font(.caption)
                        .foregroundColor(Color.gray)
                }
            }
        }
    }
}


extension GapView {
    fileprivate func takeoffCard2() -> some View {
        return Section(header: Text("Takeoff")) {
            Card {
                VStack(alignment: .leading) {
                    Text("Height: \(self.viewModel.gapParams.takeoff.height.toString(format: ".1")) m")
                    Divider()
                    Text("Length: \(self.viewModel.gapParams.takeoffLength.toString(format: ".1")) m")
                    Divider()
                    Text("Angle: \(self.viewModel.gapParams.takeoff.angle.toString(format: ".") )°")
                    Divider()
                    Text("Radius: \(self.viewModel.gapParams.takeoffRadius.toString(format: ".") )")
                }
            }
        }
    }
    
    fileprivate func landingCard2() -> some View {
        return Section(header: Header(title: "Landing")) {
            Card {
                VStack(alignment: .leading) {
                    Text("Height: \(self.viewModel.gapParams.landing.height.toString(format: ".1")) m")
                    Divider()
                    Text("Length: \(self.viewModel.gapParams.landingLength.toString(format: ".1")) m")
                    Divider()
                    Text("Angle: \(self.viewModel.gapParams.landing.angle.toString(format: ".") )°")
                }
            }
        }
    }
}


struct GapView_Previews: PreviewProvider {
    static var previews: some View {
        GapView(viewModel: GapViewModel(params: GapParams.defaultParams))
    }
}
