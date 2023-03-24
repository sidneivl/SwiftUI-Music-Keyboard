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
            .onChange(of: geo.frame(in: .global)) { _ in
                model.rectKey = geo.frame(in: .global)
            }
            .onAppear {
                model.rectKey = geo.frame(in: .global)
            }
        }
    }
}
