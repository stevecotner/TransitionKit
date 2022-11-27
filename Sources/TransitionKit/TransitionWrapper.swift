//
//  TransitionWrapper.swift
//  MatchedNavigation
//
//  Created by Stephen Cotner on 11/14/22.
//

import SwiftUI

public struct TransitionWrapper<Content>: View where Content: View {
    public var id: String
    public var content: () -> Content
    
    @EnvironmentObject private var transitionModel: TransitionModel
    
    @State var xPointLeftOfContent: CGFloat?
    @State var xPointRightOfContent: CGFloat?
    @State var yPointAboveContent: CGFloat?
    @State var yPointBelowContent: CGFloat?
    
    var originalContentHeight: CGFloat? {
        if let yPointAboveContent, let yPointBelowContent {
            return yPointBelowContent - yPointAboveContent
        }
        
        return nil
    }
    
    var originalContentWidth: CGFloat? {
        if let xPointLeftOfContent, let xPointRightOfContent {
            return xPointRightOfContent - xPointLeftOfContent
        }
        
        return nil
    }
    
    public init(id: String, content: @escaping () -> Content) {
        self.id = id
        self.content = content
    }
    
    public var body: some View {
        VStack {
            // If we've shown an expanded view, don't show the corresponding original wrapped view.
            if transitionModel.activeTransitionWrapperIDs.contains(id) {
                if transitionModel.activeSplitTransitionWrapperIDs.contains(id) {
                    // If it's a split transition, add a full-screen rectangle where the view used to be.
                    Rectangle()
                        .fill(Color.white.opacity(0.001))
                        .frame(width: 1, height: transitionModel.totalHeight != nil ? transitionModel.totalHeight! * 2 : 0.001)
                } else {
                    // Otherwise, just make sure we don't show the original view.
                    Rectangle()
                        .fill(Color.clear)
                        .frame(width: originalContentWidth, height: originalContentHeight)
                }
            } else {
                // Show the original content
                // And calculate its height, so we can use it in the above code.
                VStack(spacing: 0) {
                    GeometryReader { geometry in
                        Color.clear
                            .onAppear {
                                yPointAboveContent = geometry.frame(in: .global).maxY
                            }
                    }
                    .frame(height: 0.0001)
                    
                    HStack(spacing: 0) {
                        GeometryReader { geometry in
                            Color.clear
                                .onAppear {
                                    xPointLeftOfContent = geometry.frame(in: .global).maxX
                                }
                        }
                        .frame(width: 0.0001, height: 0.0001)
                        
                        content()
                        
                        GeometryReader { geometry in
                            Color.clear
                                .onAppear {
                                    xPointRightOfContent = geometry.frame(in: .global).minX
                                }
                        }
                        .frame(width: 0.0001, height: 0.0001)
                    }
                    
                    GeometryReader { geometry in
                        Color.clear
                            .onAppear {
                                yPointBelowContent = geometry.frame(in: .global).minY
                            }
                    }
                    .frame(height: 0.0001)
                }
            }
        }
    }
}

struct TransitionWrapper_Previews: PreviewProvider {
    static var previews: some View {
        TransitionWrapper(id: "id") { EmptyView() }
    }
}
