//
//  ToolsView.swift
//  RampBuilder
//
//  Created by Madsbook on 05.06.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

struct ToolsView: View {
    
    @State var selection: String? = nil
    @State private var navBarHidden = false
    @State var infoShown = false
    
    var speedViewModel = SpeedViewModel()
    
    func navBar() -> some View {
        return HStack {
            Text("Tools")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(Color("primary"))
            
            Spacer()
            
//            Button(action: { self.selection = "Info" }, label: {
//                Image(systemName: "info")
//            })
//                .buttonStyle(RampCircleButtonStyle())
//
//            NavigationLink(destination: InfoView(navBarHidden: self.$navBarHidden), tag: "Info", selection: $selection) {
//                EmptyView()
//            }
            
            Button(action: { self.infoShown = true }, label: {
                Image(systemName: "info")
                })
                .buttonStyle(RampCircleButtonStyle())
                .sheet(isPresented: $infoShown, content: {
                    InfoView()
                })
        }
            .padding(.horizontal)
            .padding(.leading, 14)
            .padding(.top, 56)
            .padding(.bottom, 30)
    }
    
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                
                Color("bg")
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    
                    navBar()
                                        
                    HStack(spacing: 10) {
                        NavigationLink(destination: AngleView(navBarHidden: self.$navBarHidden), tag: "Level", selection: $selection) {
                            EmptyView()
                        }
                        
                        Button(action: {
                            self.selection = "Level"
                        }, label: {
                            VStack(alignment: .leading) {
                                Image(systemName: "slash.circle")
                                    .font(.system(size: 30, weight: .light))
                                    .imageScale(.large)
                                    .padding(.bottom, 10)
                                
                                Text("Level")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(Color("primary"))
                                
                                Text("Measure angle with device level sensor")
                                    .font(.system(size: 14, weight: .light))
                                    .foregroundColor(Color("primary"))
                                    .minimumScaleFactor(0.2)
                            }
                               .frame(minWidth: 100, maxWidth: .infinity, minHeight: 100)
                        })
                            .buttonStyle(RampRoundedButtonStyle())
                        
                        
                        NavigationLink(destination: SpeedView(viewModel: self.speedViewModel, navBarHidden: $navBarHidden), tag: "Speedometer", selection: $selection) {
                            EmptyView()
                        }
                        
                        Button(action: {
                           self.selection = "Speedometer"
                        }, label: {
                            VStack(alignment: .leading) {
                                Image(systemName: "speedometer")
                                    .font(.system(size: 30, weight: .light))
                                    .imageScale(.large)
                                    .padding(.bottom, 10)

                                Text("Speedometer")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(Color("primary"))
                            
                                Text("Measure speed with device location service")
                                    .font(.system(size: 14, weight: .light))
                                    .foregroundColor(Color("primary"))
                                    .minimumScaleFactor(0.2)
                           }
                              .frame(minWidth: 100, maxWidth: .infinity, minHeight: 100)
                           })
                               .buttonStyle(RampRoundedButtonStyle())
                        
                    }
                    .padding(.trailing)
                    
                }
                 
            }
                .onAppear{
                    self.selection = nil
                    self.navBarHidden = true
                }
                .navigationBarBackButtonHidden(self.navBarHidden)
                .navigationBarHidden(self.navBarHidden)
                .navigationBarTitle("")
        }
    }
}

struct ToolsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ToolsView()
                .environment(\.locale, .init(identifier: "en"))
        }
    }
}
