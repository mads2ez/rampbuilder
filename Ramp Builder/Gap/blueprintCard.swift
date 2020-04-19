//
//  blueprintCard.swift
//  Ramp Builder
//
//  Created by Madsbook on 14.04.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

struct BluepPrintCard: View {
    var params: GapParams
    
    var color: Color = Color.init(white: 0, opacity: 0.1)
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .shadow(color: Color.gray, radius: 1)
            
            BlueprintView(params: params)
                .padding(.bottom, 25)
                .frame(width: UIScreen.main.bounds.width, height: 300)
        }
            .padding(.bottom, 15)
    }
}


struct BluepPrintCard_Previews: PreviewProvider {
    static var previews: some View {
        BluepPrintCard(params: GapParams.defaultParams)
    }
}
