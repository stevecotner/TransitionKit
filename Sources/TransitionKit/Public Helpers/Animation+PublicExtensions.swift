//
//  Animation+PublicExtensions.swift
//  TransitionKit
//
//  Created by Stephen Cotner on 11/14/22.
//

import SwiftUI

extension Animation {
    public static var transitionAdd: Self {
        .interpolatingSpring(mass: 0.039, stiffness: 2.75, damping: 0.55, initialVelocity: 0.1)
    }
    
    public static var transitionRemove: Self {
        interpolatingSpring(mass: 0.039, stiffness: 4.5, damping: 0.95, initialVelocity: 0.1)
    }
}
