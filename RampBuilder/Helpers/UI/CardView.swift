//
//  CardView.swift
//  RampBuilder
//
//  Created by Madsbook on 11.04.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

struct Card<Content: View>: View {
    private var content: Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack {
            content
        }
        .background(Color("bg"))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color("shadow1"), radius: 5, x: -5, y: -5)
        .shadow(color: Color("shadow2"), radius: 5, x: 5, y: 5)
    }
}
