//
//  ContentView.swift
//  Dice
//
//  Created by Timothy Huertas on 12/29/23.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {

    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    @Environment(\.dismissWindow) private var dismissWindow

    var body: some View {
        VStack {
            Button("Shoot Dice"){
                Task {
                    await openImmersiveSpace(id: "ImmersiveSpace")
                    dismissWindow(id: "ContentView")
                }
            }
        }
        .scaledToFit()
        
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
