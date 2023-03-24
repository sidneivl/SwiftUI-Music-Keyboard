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
    
    var touchLocations: [CGPoint] = [] {
        didSet {
            let arrayKeys = blackKeys + whiteKeys
            var arrayTouched: [KeyModel] = []
           
            for location in touchLocations {
                let keys = arrayKeys.filter( { $0.rectKey.contains(location) } )
           
                // Get specific key, verify if isBlack over or white under and make action for just key on top
                if let key: KeyModel = keys.count > 1 ? keys.first(where: { $0.isBlack } ) : keys.first {
                    arrayTouched.append(key)
                    
                    if !key.isActive {
                        key.noteOn(key)
                    }
                    key.isActive = true
                }
            }
            
            // Check if keys not pressed and relese them
            for keyRelease in arrayKeys {
                if arrayTouched.first(where: { $0.keyNumber == keyRelease.keyNumber } ) == nil {
                    if keyRelease.isActive {
                        keyRelease.noteOff(keyRelease)
                    }
                    keyRelease.isActive = false
                }
            }
        }
    }
    
    @Published var whiteKeys: [KeyModel] = []
    @Published var blackKeys: [KeyModel] = []
    
    public func keyPressed(_ keyNumber: Int, _ active: Bool) {
        whiteKeys.first(where: { $0.keyNumber == keyNumber })?.isActive = active
        blackKeys.first(where: { $0.keyNumber == keyNumber })?.isActive = active
    }
}
