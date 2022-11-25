//
//  TransitionStyle.swift
//  
//
//  Created by Stephen Cotner on 11/23/22.
//

import SwiftUI

public enum TransitionStyle {    
    case fade
    case split
    
    var isSplit: Bool {
        switch self {
        case .split:
            return true
            
        default:
            return false
        }
    }
}
