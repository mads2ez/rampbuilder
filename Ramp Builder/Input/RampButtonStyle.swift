//
//  RampButtonStyle.swift
//  Ramp Builder
//
//  Created by Madsbook on 07.04.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

struct RampButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        RampButton(configuration: configuration)
    }
    
    struct RampButton: View {
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        var body: some View {
            return configuration.label
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(Color.white)
                .background(isEnabled ? Color.blue : Color.gray)
                .cornerRadius(15)
                .padding(.horizontal, 20)
                .opacity(configuration.isPressed ? 0.4 : 1.0)
        }
    }
}
