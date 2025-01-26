import SwiftUI

struct Particle: Identifiable {
    let id: UUID
    let image: Image
    let position: CGPoint
    let offset: CGSize
    let rotation: Angle
    let size: CGFloat
}

struct Explosion: Identifiable {
    let id = UUID()
    let image: Image
    let center: CGPoint
    var particles: [Particle]
    var isExploding: Bool
    
    init(image: Image, center: CGPoint) {
        self.image = image
        self.center = center
        self.isExploding = false
        self.particles = (0..<30).map { _ in
            Particle(
                id: UUID(),
                image: image,
                position: center,
                offset: CGSize(
                    width: CGFloat.random(in: -100...100),
                    height: CGFloat.random(in: -100...100)
                ),
                rotation: Angle(degrees: Double.random(in: -360...360)),
                size: CGFloat.random(in: 10...30)
            )
        }
    }
}

struct ExplosionWithImageView: View {
    @State private var explosions: [Explosion] = []

    @State private var imagesCenters: [CGPoint] = [.zero, .zero, .zero]
    @State private var showImages: [Bool] = [true, true, true]
    
    let images: [Image] = [
        Image(systemName: "star.fill"),
        Image(systemName: "star"),
        Image(systemName: "star.fill")
    ]
    
    var body: some View {
        GeometryReader { geo in
            ZStack {

                VStack {
                    ForEach(images.indices, id: \.self) { index in
                        createImage(images[index], index: index)
                    }
                }
                .position(x: geo.size.width / 2,
                          y: geo.size.height / 2)

                
                ZStack {
                    ForEach(explosions) { explosion in
                        ZStack {
                            ForEach(explosion.particles) { particle in
                                particle.image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: particle.size, height: particle.size)
                                    .opacity(explosion.isExploding ? 0 : 1)
                                    .rotationEffect(explosion.isExploding ? particle.rotation : .zero)
                                    .animation(.easeOut(duration: 1), value: explosion.isExploding)
                                    .position(
                                        x: particle.position.x + (explosion.isExploding ? particle.offset.width : 0),
                                        y: particle.position.y + (explosion.isExploding ? particle.offset.height : 0)
                                    )
                            }
                        }
                    }
                }

            }
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    private func createImage(_ image: Image, index: Int) -> some View {
            image
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .opacity(showImages[index] ? 1 : 0)
                .overlay {
                    GeometryReader { localGeo in
                        Color.clear
                            .contentShape(Rectangle())
                            .onTapGesture {
                                let frame = localGeo.frame(in: .global)
                                let center = CGPoint(x: frame.midX, y: frame.midY)
                                imagesCenters[index] = center
                                triggerExplosion(at: index)
                            }
                    }
                }
    }
    
    private func triggerExplosion(at index: Int) {
        
        let center = imagesCenters[index]
        let tappedImage = images[index]

        withAnimation {
            showImages[index] = false
        }
        
        let newExplosion = Explosion(image: tappedImage, center: center)
        
        explosions.append(newExplosion)

        let explosionID = newExplosion.id
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            if let idx = explosions.firstIndex(where: { $0.id == explosionID }) {
                explosions[idx].isExploding = true
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if let idx = explosions.firstIndex(where: { $0.id == explosionID }) {
                explosions.remove(at: idx)
            }
            
            showImages[index] = true
        }
    }

}

#Preview {
    ExplosionWithImageView()
}
