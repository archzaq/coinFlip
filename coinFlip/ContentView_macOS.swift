//
//  ContentView_macOS.swift
//  coinFlip
//
//  Created by arch on 10/8/24.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
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

struct ContentView_macOS: View {
    @State private var coinSide: String = "Heads"
    @State private var rotation: Double = 0
    let coinSides = ["Heads", "Tails"]

    var body: some View {
        VStack {
            Image(coinSide)
                .resizable()
                .scaledToFit()
                .frame(minWidth: 200, maxWidth: 600, minHeight: 200, maxHeight: 600)
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
            .buttonStyle(CustomButtonStyle())
            .keyboardShortcut(.space, modifiers: [])
        }
        .padding()
        .frame(minWidth: 400, maxWidth: .infinity, minHeight: 400, maxHeight: .infinity)
    }

    private func flipCoin() {
        rotation += 360
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            coinSide = coinSides.randomElement() ?? "Heads"
        }
    }
}

#Preview {
    ContentView_macOS()
}

