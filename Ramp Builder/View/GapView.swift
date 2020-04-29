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
        NavigationView {
            ScrollView {
                BluepPrintCard(params: viewModel.gapParams)
                
                takeoffCard()
                
                landingCard()
                
                gapCard()
                
                stiffnessCard()
            }
                .background(Color(UIColor.systemGray6))
                .edgesIgnoringSafeArea(.bottom)
                .onAppear(perform: viewModel.refresh)
                
                .navigationBarTitle("Ramp Builder", displayMode: .inline)
                .navigationBarItems(leading:
                    Button(action: {
                        self.viewModel.infoShown = true
                    }, label: {
                        Image(systemName: "info.circle")
                            .imageScale(.large)
                    })
                        .sheet(isPresented: $viewModel.infoShown, onDismiss: viewModel.refresh,
                            content: {
                                self.viewModel.infoView
                            }), trailing:
                    Button(action: {
                        self.viewModel.inputShown = true
                    }, label: {
                        Text("Calculate")
                    })
                        .sheet(isPresented: $viewModel.inputShown, onDismiss: viewModel.refresh,
                               content: {
                                self.viewModel.inputView
                        })
            )
        }
    }
}


extension GapView {
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
