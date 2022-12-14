//
//  TransitionLink.swift
//  TransitionKit
//
//  Created by Stephen Cotner on 11/14/22.
//

import SwiftUI

public typealias TransitionCloseAction = () -> Void

public struct TransitionLink<Content>: View where Content: View {
    let viewMakerID: String
    let transitionWrapperID: String
    
    @Binding var isActive: Bool
    var transitionStyle: TransitionStyle
    var showsDefaultCloseButton: Bool
    
    /// Run after we close the link
    var closeCompletion: (() -> Void)?
    
    /// The view we will "expand" to.
    var destination: (@escaping TransitionCloseAction) -> Content
    
    @EnvironmentObject var transitionModel: TransitionModel
    
    public init(
        viewMakerID: String,
        transitionWrapperID: String,
        isActive: Binding<Bool>,
        transitionStyle: TransitionStyle = .splitVertical,
        showsDefaultCloseButton: Bool = true,
        closeCompletion: (() -> Void)? = nil,
        destination: @escaping (@escaping TransitionCloseAction) -> Content
    ) {
        self.viewMakerID = viewMakerID
        self.transitionWrapperID = transitionWrapperID
        _isActive = isActive
        self.transitionStyle = transitionStyle
        self.showsDefaultCloseButton = showsDefaultCloseButton
        self.closeCompletion = closeCompletion
        self.destination = destination
    }
    
    public var body: some View {
        Rectangle()
            .frame(width: 0.001, height: 0.001)
            .background(Color.black.opacity(0.001))
            .onChange(of: $isActive.wrappedValue) { active in
                if isActive {
                    let viewMaker = TransitionLinkViewMaker(
                        id: viewMakerID,
                        transitionWrapperID: transitionWrapperID,
                        showsDefaultCloseButton: showsDefaultCloseButton,
                        transitionStyle: transitionStyle,
                        resetActive: { isActive = false },
                        removeSelfFromViewMakers: transitionModel.remove,
                        content: destination
                    )
                    
                    transitionModel.add(viewMaker.typeErasedViewMaker)
                } else {
                    transitionModel.remove(viewMakerID)
                    closeCompletion?()
                }
            }
    }
}

struct TransitionLink_Previews: PreviewProvider {
    static var previews: some View {
        TransitionLink(
            viewMakerID: "example",
            transitionWrapperID: "example",
            isActive: .constant(true),
            transitionStyle: .splitVertical,
            destination: { _ in
                Text("Expanded Text")
            }
        )
    }
}
