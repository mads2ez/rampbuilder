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
                .padding(.horizontal, 50)
                .padding(.vertical)
                .foregroundColor(Color.white)
                .background(isEnabled ? Color.blue : Color.gray)
                .cornerRadius(10)
                .opacity(configuration.isPressed ? 0.4 : 1.0)
        }
    }
}


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
    }
}

struct Header: View {
    var title: String
    
    var body: some View {
        Text(title)
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
    }
}

struct TakeoffHeader: View {
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
//            Spacer()
            
            Button(action: {
                
            }, label:  {
                Text("Change")
            })
        }
        .padding()
        
    }
}
