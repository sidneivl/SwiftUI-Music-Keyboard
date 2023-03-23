//
//  File.swift
//  
//
//  Created by Sidnei Vladisauskis on 23/03/23.
//

import Foundation


public class KeyModel: ObservableObject, Identifiable {
    public var id = UUID().uuidString
    
    public var keyNumber: Int = 0
    
    var keyInOctave: Int = 0
    var isBlack: Bool = false
    var rectKey: CGRect = .zero
    
    @Published var isActive: Bool = false
    
    var noteOn: (_ key: KeyModel) -> Void = { _ in }
    var noteOff: (_ key: KeyModel) -> Void = { _ in }
    
    init(keyNumber: Int) {
        self.keyNumber = keyNumber
        self.keyInOctave = KeyUtils.keyInOctave(keyNumber: keyNumber)
        self.isBlack = KeyUtils.keyIsBlack(keyNumber: keyNumber)
    }
}
