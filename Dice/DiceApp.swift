//
//  DiceApp.swift
//  Dice
//
//  Created by Timothy Huertas on 12/29/23.
//

import SwiftUI

@main
struct DiceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
