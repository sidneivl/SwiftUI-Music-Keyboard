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
    
    public init(keyNumber: Int) {
        self.keyNumber = keyNumber
        self.keyInOctave = KeyInfo.keyInOctave(keyNumber: keyNumber)
        self.isBlack = KeyInfo.keyIsBlack(keyNumber: keyNumber)
    }
    
    public var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(isBlack ? .black : .white)
                .border(.black, width: 0.25)
                .cornerRadius(6.0)
        }
    }
}

struct KeyboardKey_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardKey(keyNumber: 2)
    }
}
