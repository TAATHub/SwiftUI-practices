import SwiftUI

struct AnimatedZIndexView: View {
    @State private var redAtFront = false

    let colors: [Color] = [.blue, .green, .orange, .purple, .mint]

    var body: some View {
        VStack {
            Button("Toggle zIndex") {
                withAnimation(.linear(duration: 1)) {
                    redAtFront.toggle()
                }
            }

            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(.red)
//                    .zIndex(redAtFront ? 6 : 0)
                    .animatableZIndex(redAtFront ? 6 : 0)
                    .offset(x: redAtFront ? 120 : 0, y: redAtFront ? 120 : 0)

                ForEach(0..<5) { i in
                    RoundedRectangle(cornerRadius: 25)
                        .fill(colors[i])
                        .offset(x: Double(i + 1) * 20, y: Double(i + 1) * 20)
                        .zIndex(Double(i))
                }
            }
            .frame(width: 200, height: 200)
        }
    }
}

/// A modifier let zIndex to be animatable
///
/// Confirming to Animatable protocol let us to read and write some kind of interpolated value over time.
/// ref: https://www.hackingwithswift.com/store/pro-swiftui
struct AnimatableZIndexModifier: ViewModifier, Animatable {
    var index: Double

    /// The data to animate
    var animatableData: Double {
        get { index }
        set {
            // Interpolated values like 0.1, 1.35, 4.825, and so on
            print(newValue)
            index = newValue
        }
    }

    func body(content: Content) -> some View {
        content
            .zIndex(index)
    }
}

extension View {
    func animatableZIndex(_ index: Double) -> some View {
        self.modifier(AnimatableZIndexModifier(index: index))
    }
}

#Preview {
    AnimatedZIndexView()
}