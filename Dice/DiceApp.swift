//
//  DiceApp.swift
//  Dice
//
//  Created by Timothy Huertas on 12/29/23.
//

import SwiftUI

@main
struct DiceApp: App {
    @State var appModel = AppModel()
    
    var body: some Scene {
        WindowGroup(id: "ContentView") {
            ContentView()
        }
        .windowResizability(WindowResizability.contentSize)
        
        WindowGroup(id: "ScoreView") { 
            ScoreView()
                .environment(appModel)
        }
        .windowResizability(WindowResizability.contentSize)

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
                .environment(appModel)
        }
    }

}
