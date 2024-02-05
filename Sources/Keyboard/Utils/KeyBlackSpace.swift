//
//  KeyBlackSpace.swift
//  
//
//  Created by Sidnei Vladisauskis on 22/03/23.
//

import Foundation

class KeyBlackSpace {
    static func getSpacerLeft(keyboardModel: KeyboardModel, key: KeyModel, widthStage: CGFloat) -> CGFloat {
        let whiteKeyWidth = widthStage / CGFloat(keyboardModel.whiteKeys.count)
        let blackKeyWidth = whiteKeyWidth * (keyboardModel.blackKeyProportion)
        
        // Space for first key
        if key.keyNumber - 1 == keyboardModel.firstKey {
            return whiteKeyWidth - blackKeyWidth / 2
        }
        
        if key.keyNumber - 2 == keyboardModel.firstKey {
            return (whiteKeyWidth * 2) - (blackKeyWidth / 2)
        }
        
        // Space for keys
        if key.keyInOctave == 1 || key.keyInOctave == 6 {
            return (whiteKeyWidth - blackKeyWidth / 2) * 2
        } else {
            return whiteKeyWidth * (1 - keyboardModel.blackKeyProportion)
        }
    }
    
    static func getSpaceRight(keyboardInfo: KeyboardModel, key: KeyModel, widthStage: CGFloat) -> CGFloat {
        let whiteKeyWidth = widthStage / CGFloat(keyboardInfo.whiteKeys.count)
        let blackKeyWidth = whiteKeyWidth * keyboardInfo.blackKeyProportion
        
        // Space for last key
        if key.keyNumber + 1 == keyboardInfo.lastKey {
            return whiteKeyWidth - blackKeyWidth / 2
        }
        
        if key.keyNumber + 2 == keyboardInfo.lastKey {
            return (whiteKeyWidth - blackKeyWidth / 2) + whiteKeyWidth
        }
        
        return 0.0
    }
}
