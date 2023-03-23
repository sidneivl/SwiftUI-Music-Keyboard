//
//  SwiftUIView.swift
//  
//
//  Created by Sidnei Vladisauskis on 21/03/23.
//

import SwiftUI

public struct KeyboardKey: View {
    let radius = 6.0
    
    @ObservedObject var model: KeyModel
//    @State var keyDown = false
    
    public init(model: KeyModel) {
        self.model = model
    }
    
    public var body: some View {
        GeometryReader { geo in
            VStack {
                Rectangle()
                    .foregroundColor(model.isActive ? .red : model.isBlack ? .black : .white)
                    .overlay(
                        RoundedRectangle(cornerRadius: radius)
                            .stroke(.black, lineWidth: 0.5)
                    )
                    .cornerRadius(radius)
                    .padding(.top, -radius)
            }
            .clipped()
//            .gesture(DragGesture(minimumDistance: 0.0, coordinateSpace: .global)
//                .onChanged { _ in
//                    if !keyDown {
//                        model.isActive = true
//                        model.noteOn(model)
//                    }
//                    
//                    keyDown = true
//                }
//                .onEnded { _ in
//                    keyDown = false
//                    model.isActive = false
//                    model.noteOff(model)
//                }
//            )
            .onAppear {
                model.rectKey = geo.frame(in: .global)
            }
        }
    }
}
