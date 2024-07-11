//
//  CompleteRotatingTransition.swift
//  SaveEarth
//
//  Created by 송하민 on 6/29/24.
//

import SwiftUI

struct CompleteRotatingTransition: Transition {
    func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .scaleEffect(phase.isIdentity ? 1.2 : 0)
            .rotationEffect(
                .degrees(
                    phase == .willAppear ? 360 :
                        phase == .didDisappear ? -360 : 0
                )
            )
            .blur(radius: phase.isIdentity ? 0 : 10)
    }
}

