# SwiftUIImageExplosion

**SwiftUIImageExplosion** is a custom SwiftUI effect that creates a playful “explosion” of particles from any tapped image. Each explosion shatters the tapped image into randomly sized and rotated fragments, adding a fun visual flourish to your app.

<p align="center">
  <img src="https://github.com/user-attachments/assets/7e3de837-f0b0-4305-89c7-f1032af1271c" alt="Explosion Effect Demo">
</p>


## Features
- **Easy Integration**: Simply add the provided Swift files to your project.
- **Fully Customizable**: Adjust the number of particles, rotation angles, animation duration, and offset range.
- **Works with Any Image**: Use SF Symbols, local assets, or remote images.
- **Independent Explosions**: Trigger multiple explosions without interfering with one another.

## Setup
1. **Download** or **clone** this repository.
2. **Drag and drop** the relevant `.swift` files (e.g., `ExplosionWithImageView.swift`) into your Xcode project.
3. **Start using the `ExplosionWithImageView` or adapt the core logic in your own SwiftUI views.

## Quick Start

```swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Tap the image to explode it!")
                .font(.headline)
            
            ExplosionWithImageView() // A ready-made SwiftUI view that displays the effect
        }
        .padding()
    }
}
```

## License
This project is licensed under the MIT License – see the [LICENSE](./LICENSE) file for details.
