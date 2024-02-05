# SwiftUI-Music-Keyboard

Using SwiftUI, I've created this simple keyboard for a singular personal project and I'd like to share it with you.

![keybard_playing](https://github.com/sidneivl/SwiftUI-Music-Keyboard/assets/5385276/0273638f-d3eb-414a-849d-33256affebb2)

## The features are

- multi-touch interface
- not just limited to octaves, any number of notes could be used.
- easy to use with external source of notes, such as MIDI files and MIDI ports.

## Install

Once you have your Swift package set up, adding as a dependency is as easy as adding it to the dependencies value of your Package.swift or the Package list in Xcode.

```swift
dependencies: [
    .package(url: "https://github.com/sidneivl/SwiftUI-Music-Keyboard.git", .upToNextMajor(from: "1.0.0"))
]
```


## Using

To instance the keyboard is easy like:

```swift
import SwiftUI
import Keyboard

struct KeyboardView: View {
    @State var key: [Int] = []
    
    var body: some View {
        Keyboard(firstKey: 21, lastKey: 108, keyPressed: $key)
    }
}
```

You can set the first and last key for your keyboard. By default, MIDI keyboards representing pianos start at key 21 and end at key 108.

This will set all the necessary keys to play on the visual keyboard.

### Set key pressed

The parameter **keyPressed** is a Binding array for key numbers that need to be shown as pressed on the keyboard.

```swift
import SwiftUI
import Keyboard

struct KeyboardView: View {
    @State var key: [Int] = [60, 64, 65, 84, 87, 89]
    
    var body: some View {
        Keyboard(firstKey: 21, lastKey: 108, keyPressed: $key)
    }
}
````

![key_pressed](https://github.com/sidneivl/SwiftUI-Music-Keyboard/assets/5385276/b5d4776c-1dbe-4f71-828c-c8906f565271)

### Capturing the key pressed

If you are familiar with how MIDI keyboards works, you know that key pressed and key released eventes are fired continuously.

To capture this information you heve two parameters in the contructor: noteOn (for pressed keys) and noteOff (for keys just released), both receiving a listener.

```swift
import SwiftUI
import Keyboard

struct KeyboardView: View {
    @State var key: [Int] = [60, 64, 67, 84, 87, 91]
    
    var body: some View {
        Keyboard(firstKey: 21, lastKey: 108, keyPressed: $key, noteOn: { key in
            print("\(key.keyNumber) | \(key.id)")
        }, noteOff: { key in
            print("\(key.keyNumber) | \(key.id)")
        })
    }
}
```
Listeners receive a key **KeyModel** object which contains two parameters:

- keyNumber - Reference number on keyboard
- id - The SwiftUI id

## Enjoy

It's a simple keyboard using SwiftUI, release your imagination and enjoy it!