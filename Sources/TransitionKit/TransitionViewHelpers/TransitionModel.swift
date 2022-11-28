//
//  TransitionModel.swift
//  TransitionKit
//
//  Created by Stephen Cotner on 11/16/22.
//

import SwiftUI

class TransitionModel: ObservableObject {
    var namespace: Namespace.ID?
    var totalHeight: CGFloat?
    var viewMakers: [TypeErasedTransitionLinkViewMaker] = []
    
    var activeTransitionWrapperIDs: [String] {
        return viewMakers.compactMap {
            return $0.transitionWrapperID
        }
    }
    
    var activeSplitTransitionWrapperIDs: [String] {
        return viewMakers.compactMap {
            if $0.transitionStyle == .splitVertical { return $0.transitionWrapperID }
            return nil
        }
    }
    
    func add(_ viewMaker: TypeErasedTransitionLinkViewMaker) {
        viewMakers.append(viewMaker)
        
        withAnimation(.transitionAdd) {
            self.objectWillChange.send()
        }
    }
    
    func remove(_ viewMakerID: String) {
        viewMakers.removeAll(where: { $0.id == viewMakerID })
        
        withAnimation(.transitionRemove) {
            self.objectWillChange.send()
        }
    }
}
