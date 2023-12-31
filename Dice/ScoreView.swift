//
//  ScoreView.swift
//  Dice
//
//  Created by Timothy Huertas on 12/30/23.
//

import SwiftUI

struct ScoreView: View {
    @Environment(AppModel.self) private var appModel

    var body: some View {
        if let diceValue = appModel.diceValue {
            Text("\(diceValue)")
                .font(.system(size: 40))
        }
        
    }
}

#Preview {
    ScoreView()
}
