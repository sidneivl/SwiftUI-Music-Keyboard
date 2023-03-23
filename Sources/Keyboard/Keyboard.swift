import SwiftUI

public struct Keyboard: View {
    @ObservedObject public var keyboardModel: KeyboardModel = .init()
    
    var firstKey: Int
    var lastKey: Int
    var noteOn: (_ key: KeyModel) -> Void
    var noteOff: (_ key: KeyModel) -> Void
    
    @Binding var keyPressed: [Int]
    
    public init(firstKey: Int,
                lastKey: Int,
                keyPressed: Binding<[Int]>,
                noteOn: @escaping (_ key: KeyModel) -> Void,
                noteOff: @escaping (_ key: KeyModel) -> Void)
    {
        self.firstKey = firstKey
        self.lastKey = lastKey
        self._keyPressed = keyPressed
        self.noteOn = noteOn
        self.noteOff = noteOff
    }
    
    private func setModel() {
        keyboardModel.firstKey = KeyUtils.keyIsBlack(keyNumber: firstKey) ? firstKey - 1 : firstKey
        keyboardModel.lastKey = KeyUtils.keyIsBlack(keyNumber: lastKey) ? lastKey + 1 : lastKey
    
        for i in (keyboardModel.firstKey...keyboardModel.lastKey) {
            let key = KeyModel(keyNumber: i)
            key.noteOn = self.noteOn
            key.noteOff = self.noteOff

            if key.isBlack {
                keyboardModel.blackKeys.append(key)
            } else {
                keyboardModel.whiteKeys.append(key)
            }
        }
    }
    
    private func setKeysPressed() {
        // TODO: check if is better solution for performance
        for i in (keyboardModel.firstKey...keyboardModel.lastKey) {
            keyboardModel.keyPressed(i, keyPressed.contains(i) ? true : false)
        }
    }
    
    private func getKeyWidth(_ geoWidth: CGFloat) -> CGFloat {
        let keysCount = CGFloat(keyboardModel.whiteKeys.count)
        let keyboardProportion = keyboardModel.blackKeyProportion
        return geoWidth / keysCount * keyboardProportion
    }
    
    public var body: some View {
        GeometryReader { geo in
            ZStack {                
                HStack(spacing: 0) {
                    ForEach(keyboardModel.whiteKeys) { keyModel in
                        KeyboardKey(model: keyModel)
                    }
                }.zIndex(0)

                VStack(alignment: .leading) {
                    HStack(alignment: .top, spacing: 0) {
                        ForEach(keyboardModel.blackKeys) { keyModel in
                            Rectangle().opacity(0).frame(width: KeyBlackSpace.getSpacerLeft(keyboardModel: keyboardModel, key: keyModel, widthStage: geo.size.width))
                            KeyboardKey(model: keyModel)

                            if keyModel.keyNumber + 1 == keyboardModel.lastKey || keyModel.keyNumber + 2 == keyboardModel.lastKey {
                                Rectangle().opacity(0).frame(width: KeyBlackSpace.getSpaceRight(keyboardInfo: keyboardModel, key: keyModel, widthStage: geo.size.width))
                            }
                        }
                    }
                    Spacer().frame(height: geo.size.height * 0.35)
                }.zIndex(1)
            }
            
            MultitouchView { touches in
                keyboardModel.touchLocations = touches
            }
        }
        .onAppear {
            setModel()
            setKeysPressed()
        }
        .onChange(of: $keyPressed.wrappedValue, perform: { value in
            setKeysPressed()
        })
    }
}
