//
//  Buttons.swift
//  RampBuilder
//
//  Created by Madsbook on 20.05.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

struct RampRoundedButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .contentShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .padding()
            .foregroundColor(configuration.isPressed ? .secondary : .accentColor)
            .font(.system(size: 18, weight: .medium))
            .background(
                Group {
                    if configuration.isPressed {
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(Color("bg"))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .stroke(Color.black, lineWidth: 4)
                                    .blur(radius: 4)
                                    .offset(x: 2, y: 2)
                                    .mask(RoundedRectangle(cornerRadius: 16, style: .continuous).fill(LinearGradient(gradient: Gradient(colors: [Color.black, Color.clear]), startPoint: .top, endPoint: .bottom)))
                            )
                    } else {
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(Color("bg"))
//                            .shadow(radius: 5, x: 0, y: 5)
                            .shadow(color: Color("shadow1"), radius: 5, x: -5, y: -5)
                            .shadow(color: Color("shadow2"), radius: 5, x: 5, y: 5)
                    }
                }
            )
    }
}

struct RampCircleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? .secondary : .primary)
            .font(.system(size: 16, weight: .medium))
            .frame(width: 36, height: 36)
            .contentShape(Circle())
            .background(
                Group {
                    if configuration.isPressed {
                        Circle()
                            .fill(Color("bg"))
                            .overlay(
                                Circle()
                                    .stroke(Color.black, lineWidth: 4)
                                    .blur(radius: 4)
                                    .offset(x: 2, y: 2)
                                    .mask(Circle().fill(LinearGradient(gradient: Gradient(colors: [Color.black, Color.clear]), startPoint: .topLeading, endPoint: .bottomTrailing)))
                            )
                    } else {
                        Circle()
                            .fill(Color("bg"))
                            .shadow(color: Color("shadow1"), radius: 5, x: -5, y: -5)
                            .shadow(color: Color("shadow2"), radius: 5, x: 5, y: 5)
                    }
                }
            )
    }
}
