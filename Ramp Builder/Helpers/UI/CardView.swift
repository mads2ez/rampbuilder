//
//  CardView.swift
//  Ramp Builder
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
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .padding(.horizontal)
        .padding(.bottom, 20)
        .shadow(radius: 1)
    }
}
