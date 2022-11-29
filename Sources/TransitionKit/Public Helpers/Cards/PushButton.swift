//
//  PushButton.swift
//  SampleApp
//
//  Created by Stephen Cotner on 11/26/22.
//

import SwiftUI

public struct PushButton: ButtonStyle {
    public init() {}
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.spring(response: 0.35, dampingFraction: 0.6, blendDuration: 0), value: configuration.isPressed)
    }
}
