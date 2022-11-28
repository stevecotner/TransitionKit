//
//  TransitionView.swift
//  TransitionKit
//
//  Created by Stephen Cotner on 11/14/22.
//

import SwiftUI

public struct TransitionView<Content>: View where Content: View {
    public var content: (Namespace.ID) -> Content
    
    @StateObject private var transitionModel = TransitionModel()
    @Namespace var namespace
    
    public init(_ content: @escaping (Namespace.ID) -> Content) {
        self.content = content
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                content(namespace)
                    .opacity(transitionModel.viewMakers.count > 0 ? 0 : 1)
                    .frame(
                        width: transitionModel.viewMakers.count > 0 &&
                            transitionModel.viewMakers.first?.transitionStyle == .explode
                        ? geometry.size.width * 2 : geometry.size.width,
                        height: transitionModel.viewMakers.count > 0 &&
                           (transitionModel.viewMakers.first?.transitionStyle == .splitVertical ||
                            transitionModel.viewMakers.first?.transitionStyle == .explode)
                            ? geometry.size.height * 2 : geometry.size.height)
                    .offset(
                        x: transitionModel.viewMakers.count > 0 &&
                         transitionModel.viewMakers.first?.transitionStyle == .explode
                        ? -geometry.size.width * 0.5 :
                            0,
                        y: transitionModel.viewMakers.count > 0 &&
                            (transitionModel.viewMakers.first?.transitionStyle == .splitVertical ||
                             transitionModel.viewMakers.first?.transitionStyle == .explode)
                            ? -geometry.size.height :
                                0)
                
                ForEach(Array(transitionModel.viewMakers.enumerated()), id: \.element.id) { index, viewMaker in
                    ZStack(alignment: .top) {
                        viewMaker.content()
                        
                        if viewMaker.showsXButton {
                            VStack {
                                HStack {
                                    Spacer()
                                    Button {
                                        removeAndResetActive(viewMaker)
                                    } label: {
                                        Image(systemName: "xmark.circle.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 26)
                                            .foregroundColor(.black)
                                    }
                                }
                                Spacer()
                            }
                            .padding(.horizontal, 12)
                        }
                    }
                    .opacity(index < transitionModel.viewMakers.count - 1 ? 0 : 1)
                    .frame(
                        width: width(forChildIndex: index, geometryWidth: geometry.size.width),
                        height: index < transitionModel.viewMakers.count - 1
                        && transitionModel.viewMakers.count > index + 1
                        && (
                            transitionModel.viewMakers[index + 1].transitionStyle == .splitVertical
                            || transitionModel.viewMakers[index + 1].transitionStyle == .explode
                            )
                        ?
                        geometry.size.height * 2 : geometry.size.height
                    )
                    .offset(
                        x: xOffset(forChildIndex: index, geometryWidth: geometry.size.width),
                        y: index < transitionModel.viewMakers.count - 1
                        && transitionModel.viewMakers.count > index + 1
                        && (
                            transitionModel.viewMakers[index + 1].transitionStyle == .splitVertical
                            || transitionModel.viewMakers[index + 1].transitionStyle == .explode
                            )
                        ?
                        -geometry.size.height : 0)
                }
            }
            .environmentObject(transitionModel)
            .onAppear() {
                transitionModel.namespace = namespace
                transitionModel.totalWidth = geometry.size.width
                transitionModel.totalHeight = geometry.size.height
            }
        }
    }
    
    func width(forChildIndex index: Int, geometryWidth: CGFloat) -> CGFloat {
        index < transitionModel.viewMakers.count - 1
        && transitionModel.viewMakers.count > index + 1
        && transitionModel.viewMakers[index + 1].transitionStyle == .explode
        ?
        geometryWidth * 2 : geometryWidth
    }
    
    func xOffset(forChildIndex index: Int, geometryWidth: CGFloat) -> CGFloat {
        // Exploded parent
        index < transitionModel.viewMakers.count - 1
        && transitionModel.viewMakers.count > index + 1
        && transitionModel.viewMakers[index + 1].transitionStyle == .explode
        ?
        -geometryWidth * 0.5 :
        // Exploded child
        index == transitionModel.viewMakers.count - 1
        && transitionModel.viewMakers[index].transitionStyle == .explode
        ?
        -geometryWidth * 0.5 :
        // Everything else
        0
    }
    
    func removeAndResetActive(_ viewMaker: TypeErasedTransitionLinkViewMaker) {
        viewMaker.resetActive()
        transitionModel.remove(viewMaker.id)
    }
}
