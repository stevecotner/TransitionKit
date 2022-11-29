//
//  TransitionLinkViewMaker.swift
//  MatchedNavigation
//
//  Created by Stephen Cotner on 11/16/22.
//

import SwiftUI

struct TransitionLinkViewMaker<Content> where Content: View {
    var id: String
    var transitionWrapperID: String
    let showsDefaultCloseButton: Bool
    let transitionStyle: TransitionStyle
    var resetActive: () -> Void
    var removeSelfFromViewMakers: (String) -> Void
    var content: (@escaping TransitionCloseAction) -> Content
    var typeErasedViewMaker: TypeErasedTransitionLinkViewMaker {
        let anyfiedContent = {
            AnyView(
                content(
                    {
                        resetActive()
                        removeSelfFromViewMakers(id)
                    }
                )
            )
        }
        
        return TypeErasedTransitionLinkViewMaker(
            id: id,
            transitionWrapperID: transitionWrapperID,
            showsDefaultCloseButton: showsDefaultCloseButton,
            transitionStyle: transitionStyle,
            resetActive: resetActive,
            content: anyfiedContent
        )
    }
}

struct TypeErasedTransitionLinkViewMaker {
    var id: String
    var transitionWrapperID: String
    let showsDefaultCloseButton: Bool
    let transitionStyle: TransitionStyle
    var resetActive: () -> Void
    var content: () -> AnyView
}
