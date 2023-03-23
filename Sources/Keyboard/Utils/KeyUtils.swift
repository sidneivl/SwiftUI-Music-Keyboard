//
//  KeyInfo.swift
//  
//
//  Created by Sidnei Vladisauskis on 22/03/23.
//

import Foundation

class KeyUtils {
    private static let keysInOctave = 12
    private static let baseNoteKey = [0, 2, 4, 5, 7, 9, 11]
    
    static func keyInOctave(keyNumber: Int) -> Int {
        let octave = Int(floor(Double(keyNumber / keysInOctave)))
        return keyNumber - (octave * keysInOctave)
    }
    
    static func keyIsBlack(keyNumber: Int) -> Bool {
        return !baseNoteKey.contains(keyInOctave(keyNumber: keyNumber)) ? true : false
    }
}
