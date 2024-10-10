//
//  ContentView_iOS.swift
//  coinFlip
//
//  Created by arch on 10/8/24.
//

import SwiftUI

struct CustomButtonStyle_iOS: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.largeTitle)
            .padding()
            .background(Color.blue.opacity(configuration.isPressed ? 0.7 : 1))
            .foregroundColor(Color.white.opacity(configuration.isPressed ? 0.3 : 1))
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(), value: configuration.isPressed)
    }
}

struct ContentView_iOS: View {
    @State private var coinSide: String = "Heads"
    @State private var rotation: Double = 0
    let coinSides = ["Heads", "Tails"]

    var body: some View {
        VStack {
            Image(coinSide)
                .resizable()
                .scaledToFit()
                .rotation3DEffect(
                    .degrees(rotation),
                    axis: (x: 1, y: 0, z: 0)
                )
                .animation(.easeInOut(duration: 0.5), value: rotation)
                .padding(20)
                .onTapGesture {
                    flipCoin()
                }

            Button {
                flipCoin()
            } label: {
                Text("Flip Coin")
            }
            .padding()
            .buttonStyle(CustomButtonStyle_iOS())
        }
        .padding()
    }

    private func flipCoin() {
        rotation += 360
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            coinSide = coinSides.randomElement() ?? "Heads"
        }
    }
}

#Preview {
    ContentView_iOS()
}
