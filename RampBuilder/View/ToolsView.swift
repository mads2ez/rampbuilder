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
    
//    init() {
//        UINavigationBar.appearance().barTintColor = UIColor(named: "bg")
//        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(named: "primary")]
//        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(named: "primary")]
//    }
    
    func navBar() -> some View {
        return HStack {
            Text("Tools")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(Color("primary"))
            
            Spacer()
            
            Button(action: { self.selection = "Info" }, label: {
                Image(systemName: "info")
            })
                .buttonStyle(RampCircleButtonStyle())
            
            NavigationLink(destination: InfoView(navBarHidden: self.$navBarHidden), tag: "Info", selection: $selection) {
                EmptyView()
            }
        }
            .padding(.horizontal)
            .padding(.leading, 14)
            .padding(.top, 56)
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
                            }
                               .frame(minWidth: 100, maxWidth: .infinity, minHeight: 100)
                        })
                            .buttonStyle(RampRoundedButtonStyle())
                        
                    
                     
                        NavigationLink(destination: SpeedView(navBarHidden: self.$navBarHidden), tag: "Speedometer", selection: $selection) {
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
//                .navigationBarTitle("Tools")
            
        }
    }
    
    
//    fileprivate func listView() -> some View {
    //        return List {
    //            Section(footer: Text("Measure angles and speed with device sensors")) {
    //                NavigationLink(destination: AngleView()) {
    //                    Image(systemName: "slash.circle")
    //                        .foregroundColor(Color.blue)
    //                    Text("Level")
    //                }
    //                NavigationLink(destination: SpeedView()) {
    //                    Image(systemName: "gauge")
    //                        .foregroundColor(Color.blue)
    //                    Text("Speedometer")
    //                }
    //            }
    //            Section {
    //                NavigationLink(destination: InfoView(navBarHidden: self.$navBarHidden)) {
    //                    Image(systemName: "info.circle")
    //                        .foregroundColor(Color.blue)
    //                    Text("About")
    //                }
    //            }
    //        }
    //        .listStyle(GroupedListStyle())
    //    }
}

struct ToolsView_Previews: PreviewProvider {
    static var previews: some View {
        ToolsView()
            .environment(\.locale, .init(identifier: "ru"))
    }
}
