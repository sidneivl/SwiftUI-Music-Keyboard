//
//  File.swift
//  
//
//  Created by Sidnei Vladisauskis on 23/03/23.
//

import SwiftUI

public class KeyboardModel: ObservableObject {
    let blackKeyProportion: CGFloat = 0.7
    
    var firstKey: Int = 21
    var lastKey: Int = 108
    
    var noteOn: (_ key: KeyModel) -> Void = { _ in }
    var noteOff: (_ key: KeyModel) -> Void = { _ in }
    
    @Published var whiteKeys: [KeyModel] = []
    @Published var blackKeys: [KeyModel] = []
    
    public func keyPressed(_ keyNumber: Int, _ active: Bool) {
        whiteKeys.first(where: { $0.keyNumber == keyNumber })?.isActive = active
        blackKeys.first(where: { $0.keyNumber == keyNumber })?.isActive = active
    }
}
