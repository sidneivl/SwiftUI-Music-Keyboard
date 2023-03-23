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
            
            if touchLocations.isEmpty {
                for key in arrayKeys {
                    if key.isActive {
                        key.noteOff(key)
                    }
                    key.isActive = false
                }
                return
            }
           
            // TODO: try improve that
            for location in touchLocations {
                for key in arrayKeys {
                    if key.rectKey.contains(location) {
                        if key.isBlack {
                            if !key.isActive {
                                key.noteOn(key)
                            }
                            key.isActive = true
                            for key in whiteKeys {
                                key.isActive = false
                            }
                            return
                        }
                        
                        if !key.isBlack {
                            if !key.isActive {
                                key.noteOn(key)
                            }
                            key.isActive = true
                        }
                    } else {
                        if key.isActive {
                            key.noteOff(key)
                        }
                        key.isActive = false
                    }
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
