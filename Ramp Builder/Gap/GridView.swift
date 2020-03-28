//
//  SwiftUIView.swift
//  Ramp Builder
//
//  Created by Madsbook on 23.01.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI

struct HorizontalLineView: View {
    let y: Int
    var color = Color.gray
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Path { path in
                    path.move(to: CGPoint(x: 0, y: geometry.size.height))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
                }
                .stroke(self.color, lineWidth: 0.5)
                
                Text(String(self.y))
                    .font(.caption)
                    .fontWeight(.thin)
                    .offset(x: -(geometry.size.width/2) - 10, y: geometry.size.height/2)
            }
            .animation(.easeInOut(duration: 0.6))
        }
    }
}

struct VerticalLineView: View {
    let x: Int
    var color = Color.gray
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Path { path in
                    path.move(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: 0))
                }
                .stroke(self.color, lineWidth: 0.5)
                
                Text(String(self.x))
                    .font(.caption)
                    .fontWeight(.thin)
                    .offset(x: -geometry.size.width/2, y: geometry.size.height/2 + 10)
            }
            .animation(.easeInOut(duration: 0.6))
        }
    }
}


struct GridView: View {
    var step: CGFloat
    var color = Color.gray
    
    var body: some View {
        GeometryReader { geometry in
            self.drawGrid(geometry)
        }
    }
    
    func drawGrid(_ geometry: GeometryProxy) -> some View {
        let stepsX = Array(0..<Int(geometry.size.width / step))
        let stepsY = Array(0..<Int(geometry.size.height / step))
        
        return ZStack(alignment: .bottomLeading) {
            Rectangle()
                .stroke(color, lineWidth: 0.5)
            
            VStack(spacing: 0) {
                ForEach(stepsY.reversed(), id: \.self) { mark in
                    HorizontalLineView(y: mark, color: self.color).frame(width: geometry.size.width, height: self.step)
                }
            }
                     
            HStack(spacing: 0) {
                ForEach(stepsX, id: \.self) { mark in
                    VerticalLineView(x: mark, color: self.color).frame(width: self.step, height: geometry.size.height)
                }
            }
        }
    }
}


struct YGridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView(step: 100)
            .frame(width: 300, height: 300)
            .offset(x: 0, y: 0)
            .environment(\.colorScheme, .dark)
    }
}
