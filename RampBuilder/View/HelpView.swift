//
//  HelpView.swift
//  RampBuilder
//
//  Created by Madsbook on 25.11.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

// TODO Analytics

struct HelpCardItem: Hashable {
    var title: String
    var text: String
    var image: String?
    
    static let defaultCards: [HelpCardItem] = {
        let item1 = HelpCardItem(title: NSLocalizedString("helpViewTakeoffTitle", comment: ""), text: NSLocalizedString("helpViewTakeoffText", comment: ""), image: "takeoff")
        let item2 = HelpCardItem(title: NSLocalizedString("helpViewLadingTitle", comment: ""), text: NSLocalizedString("helpViewLandingText", comment: ""), image: "landing")
        let item3 = HelpCardItem(title: NSLocalizedString("helpViewGapTitle", comment: ""), text: NSLocalizedString("helpViewGapText", comment: ""), image: "gapandspeed")
        return [item1, item2, item3]
    }()
}

class HelpViewModel {
    var items: [HelpCardItem]
    
    init() {
        items = HelpCardItem.defaultCards
    }
}


struct HelpView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var viewModel: HelpViewModel
    
    init() {
        viewModel = HelpViewModel()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("bg")
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    ScrollView {
                        
                        ForEach(viewModel.items, id: \.self) { item in
                        
                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
                                
                                RoundedRectangle(cornerRadius: 25, style: .continuous)
                                    .fill(Color(UIColor.tertiarySystemBackground))
                                    .shadow(color: Color("shadow1"), radius: 2, x: -2, y: -2)
                                    .shadow(color: Color("shadow2"), radius: 2, x: 2, y: 2)
                                
                                VStack(alignment: .leading) {
                                    
                                    HStack(alignment: .bottom) {
                                        Text(item.title)
                                            .font(.system(size: 24, weight: .bold))
                                            
                                        
                                        Spacer()
                                        
                                        if item.image != nil {
                                            Image(item.image!)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(maxHeight: 50)
                                                .clipped()
                                        }
                                    }
                                        .padding(.top)
                                        .padding(.horizontal)
                                        .padding(.bottom, 5)
                                    
                                    Text(item.text)
                                        .lineLimit(nil)
                                        .padding(.horizontal)
                                        .padding(.bottom)
                                        
                                }
                                    .foregroundColor(Color("primary"))
                                
                            }
                                .padding(.top)
                                .padding(.horizontal)
                            
                        } // foreach
                    } // scrollview
                }
            }
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarItems(
                    leading:
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Dismiss")
                            .foregroundColor(Color("accent"))
                    }))
        }
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView().environment(\.colorScheme, .light)
    }
}
