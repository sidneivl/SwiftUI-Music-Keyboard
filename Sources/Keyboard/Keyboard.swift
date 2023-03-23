import SwiftUI

struct KeyboardInfo {
    let blackKeyProportion: CGFloat = 0.7
    
    var firstKey: Int = 21
    var lastKey: Int = 108
    
    var whiteKeys: [KeyboardKey] = []
    var blackKeys: [KeyboardKey] = []
}

public struct Keyboard: View {
    private var keyboardInfo = KeyboardInfo()
    
    public init(firstKey: Int, lastKey: Int) {
        keyboardInfo.firstKey = KeyInfo.keyIsBlack(keyNumber: firstKey) ? firstKey - 1 : firstKey
        keyboardInfo.lastKey = KeyInfo.keyIsBlack(keyNumber: lastKey) ? lastKey + 1 : lastKey

        for i in (keyboardInfo.firstKey...keyboardInfo.lastKey) {
            let key = KeyboardKey(keyNumber: i)

            if key.isBlack {
                keyboardInfo.blackKeys.append(key)
            } else {
                keyboardInfo.whiteKeys.append(key)
            }
        }
    }
    
    public var body: some View {
        GeometryReader { geo in
            ZStack {
                HStack(spacing: 0) {
                    ForEach(keyboardInfo.whiteKeys, id: \.self) { key in
                        key
                    }
                }.zIndex(0)

                VStack(alignment: .leading) {
                    HStack(alignment: .top, spacing: 0) {
                        ForEach(keyboardInfo.blackKeys, id: \.self) { key in
                            Rectangle().opacity(0).frame(width: KeyBlackSpace.getSpacerLeft(keyboardInfo: keyboardInfo, key: key, widthStage: geo.size.width))

                            let keysCount = CGFloat(keyboardInfo.whiteKeys.count)
                            let keyboardProportion = keyboardInfo.blackKeyProportion
                            let widthKey = geo.size.width / keysCount * keyboardProportion
                            key.frame(width: widthKey)

                            if key.keyNumber + 1 == keyboardInfo.lastKey || key.keyNumber + 2 == keyboardInfo.lastKey {
                                Rectangle().opacity(0).frame(width: KeyBlackSpace.getSpaceRight(keyboardInfo: keyboardInfo, key: key, widthStage: geo.size.width))
                            }
                        }
                    }
                    Spacer().frame(height: geo.size.height * 0.35)
                }.zIndex(1)
            }
        }
    }
}
