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
                blueprintView()
                
                
                
                
                
                takeoffCard()
                
                landingCard()
                
                gapCard()
                
                stiffnessCard()
            }
                .background(Color(UIColor.systemGroupedBackground))
                .edgesIgnoringSafeArea(.bottom)
                .onAppear(perform: viewModel.refresh)
                
                .navigationBarTitle("Ramp Builder", displayMode: .inline)
                .navigationBarItems(leading:
                    Button(action: {
                        self.viewModel.infoShown = true
                    }, label: {
                        Image(systemName: "info.circle")
                            .font(.system(size: 24))
                    })
                        .sheet(isPresented: $viewModel.infoShown, onDismiss: viewModel.refresh,
                            content: {
                                self.viewModel.infoView
                            })
            )
        }
    }
}


extension GapView {
    func blueprintView() -> some View {
        return ZStack {
            Rectangle()
                .fill(Color(UIColor.tertiarySystemBackground))
                .shadow(color: Color.gray, radius: 1)
            
            VStack {
                BlueprintView(params: viewModel.gapParams)
                    .padding(.bottom, 25)
                    .frame(width: UIScreen.main.bounds.width, height: 300)
                
                Divider()
                
                Button(action: {
                    self.viewModel.inputShown = true
                }, label: {
                    Text("Calculate")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    })
                    .sheet(isPresented: self.$viewModel.inputShown, onDismiss: self.viewModel.refresh,
                           content: {
                            self.viewModel.inputView
                    })
            }
        }
        .padding(.bottom, 15)
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
                    Text("Landing stiffness: \((self.viewModel.gapParams.landingStiffness.toString(format: ".1"))) m")
                        .fixedSize(horizontal: false, vertical: true)

                    Divider()
                    
                    Text("Stiffness is equivalent to the height of the drop on a flat landing")
                        .font(.caption)
                        .foregroundColor(.secondary)
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
        GapView(viewModel: GapViewModel(params: GapParams.defaultParams)).environment(\.colorScheme, .light)
    }
}
