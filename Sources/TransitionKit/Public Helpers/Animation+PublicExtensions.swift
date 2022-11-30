//
//  Animation+PublicExtensions.swift
//  TransitionKit
//
//  Created by Stephen Cotner on 11/14/22.
//

import SwiftUI

extension Animation {
    public static var transitionAdd: Self {
        .interpolatingSpring(mass: 0.042, stiffness: 2.75, damping: 0.6, initialVelocity: 0.1)
    }
    
    public static var transitionRemove: Self {
        interpolatingSpring(mass: 0.045, stiffness: 4.0, damping: 0.85, initialVelocity: 0.01)
    }
}
