//
//  ImmersiveView.swift
//  Dice
//
//  Created by Timothy Huertas on 12/29/23.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    @Environment(AppModel.self) private var appModel
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow


    @State private var isScoreViewShowing = false
    @State private var hasRolled = false
    
    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content
            if let scene = try? await Entity(named: "Immersive", in: realityKitContentBundle) {
                content.add(scene)
                
                // todo maybe convert to system
                _ = content.subscribe(to: CollisionEvents.Began.self, on: scene.findEntity(named: "dice")?.children.first) { collisionEvent in
                    print("💥 Collision between \(collisionEvent.entityA.name) and \(collisionEvent.entityB.name)")
                    if let dice = scene.findEntity(named: "dice")?.children.first {
                        if let motion = dice.components[PhysicsMotionComponent.self] {
                            print(motion.angularVelocity)
                            let axisWithMaxY = [
                                0: dice.convert(direction: SIMD3<Float>(1, 0, 0), to: nil).y,
                                1: dice.convert(direction: SIMD3<Float>(0, 1, 0), to: nil).y,
                                2: dice.convert(direction: SIMD3<Float>(0, 0, 1), to: nil).y
                            ].sorted(by: {abs($0.value) > abs($1.value)}).first!
                            let valueIndex = axisWithMaxY.value < 0 ? 1  : 0
                            appModel.diceValue = [[1,6], [4,3], [2,5]][axisWithMaxY.key][valueIndex]
                            print(appModel.diceValue!)

                            if(hasRolled && !isScoreViewShowing) {
                                isScoreViewShowing = true
                                openWindow(id: "ScoreView")
                            }
                        }
                    }
                }
            }
        }
        .gesture(dragGesture)
//        .gesture(tapGesture)
    }
    
    
    var dragGesture: some Gesture {
        DragGesture()
            .targetedToAnyEntity()
            .onChanged { value in
                dismissWindow(id: "ScoreView")
                isScoreViewShowing = false
                appModel.diceValue = nil
                value.entity.position = value.convert(value.location3D, from: .local, to: value.entity.parent!)
                value.entity.components[PhysicsBodyComponent.self]?.mode = .kinematic
            }
            .onEnded { value in
                hasRolled = true
                value.entity.components[PhysicsBodyComponent.self]?.mode = .dynamic
            }
    }
    
    var tapGesture: some Gesture {
        //https://developer.apple.com/documentation/spritekit/skphysicsbody/making_physics_bodies_move
        SpatialTapGesture()
            .targetedToAnyEntity()
            .onEnded() { value in
                print("tapped", value.entity.name)
                if let modelEntity = value.entity as? ModelEntity {
                    print("tapp", modelEntity.name)
                    modelEntity.applyLinearImpulse([0, -0.009, -0.01], relativeTo: nil)
                }
            }
    }
}

#Preview {
    ImmersiveView()
        .previewLayout(.sizeThatFits)
}
