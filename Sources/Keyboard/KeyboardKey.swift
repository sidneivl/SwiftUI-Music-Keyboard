//
//  SwiftUIView.swift
//  
//
//  Created by Sidnei Vladisauskis on 21/03/23.
//

import SwiftUI

public struct KeyboardKey: View, Hashable {
    var keyNumber: Int
    var keyInOctave: Int
    var isBlack: Bool
    
    let radius = 6.0
    
    public init(keyNumber: Int) {
        self.keyNumber = keyNumber
        self.keyInOctave = KeyInfo.keyInOctave(keyNumber: keyNumber)
        self.isBlack = KeyInfo.keyIsBlack(keyNumber: keyNumber)
    }
    
    public var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(isBlack ? .black : .white)
                .overlay(
                    RoundedRectangle(cornerRadius: radius)
                        .stroke(.black, lineWidth: 0.5)
                )
                .cornerRadius(radius)
                .padding(.top, -radius)
        }
        .clipped()
    }
}

struct KeyboardKey_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardKey(keyNumber: 2)
    }
}
