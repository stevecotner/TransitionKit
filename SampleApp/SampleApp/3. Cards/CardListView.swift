//
//  CardListView.swift
//  SampleApp
//
//  Created by Stephen Cotner on 11/23/22.
//

import SwiftUI
import TransitionKit

struct CardListView: View {
    @State var characters: [SimpsonsCharacter] = SimpsonsCharacter.makeCharacters()
    @State var activeHorizontalCharacter: SimpsonsCharacter? {
        willSet {
            if newValue == nil {
                hideTabBar = false
            }
        }
    }
    
    @State var activeVerticalCharacter: SimpsonsCharacter? {
        willSet {
            if newValue == nil {
                hideTabBar = false
            }
        }
    }
    
    @State private var hideTabBar = false
    @State private var horizontalTransitionStyle = TransitionStyle.fade
    @State private var verticalTransitionStyle = TransitionStyle.splitVertical
    
    let horizontalPadding: CGFloat = 22
    
    var body: some View {
        GeometryReader { geometry in
            TransitionView { namespace in
                ZStack {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 30) {
                            Text("Cards")
                                .padding(.horizontal, horizontalPadding)
                                .padding(.top, 20)
                                .font(.title.bold())
                            
                            Text(
                                """
                                Tap any card to see it take over the screen. Its image and title move to new positions. A description appears after half a second.
                                """)
                            .padding(.horizontal, horizontalPadding)
                            .padding(.top, -10)
                            
                            Text("Horizontal")
                                .padding(.horizontal, horizontalPadding)
                                .font(.title3.bold())
                            
                            TransitionStylePicker(transitionStyle: $horizontalTransitionStyle)
                                .zIndex(2)
                                .padding(.horizontal, horizontalPadding)
                                .padding(.top, -20)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 20) {
                                    ForEach(characters, id: \.id) { character in
                                        let id = character.id + "horizontal"
                                        
                                        TransitionWrapper(id: id) {
                                            Button {
                                                showHorizontal(character: character)
                                            } label: {
                                                CardView(matchedGeometryID: id) {
                                                    SimpsonsCharacterCardContent(character: character, matchedGeometryID: id)
                                                }
                                                .matchedGeometryEffect(id: id + "wholecard", in: namespace)
                                                .frame(height: 280)
                                                .padding(.vertical, 30)
                                            }
                                            .buttonStyle(PushButton())
                                        }
                                    }
                                }
                                .padding(.horizontal, horizontalPadding)
                                .padding(.vertical, 100)
                                .zIndex(1)
                            }
                            .frame(width: geometry.size.width)
                            .padding(.vertical, -100)
                            .padding(.top, -30)
                            .zIndex(1)
                            
                            Text("Vertical")
                                .padding(.horizontal, horizontalPadding)
                                .padding(.top, 20)
                                .font(.title3.bold())
                            
                            TransitionStylePicker(transitionStyle: $verticalTransitionStyle)
                                .zIndex(2)
                                .padding(.horizontal, horizontalPadding)
                                .padding(.top, -20)
                            
                            ForEach(characters, id: \.id) { character in
                                let id = character.id + "vertical"
                                
                                TransitionWrapper(id: id) {
                                    Button {
                                        showVertical(character: character)
                                    } label: {
                                        CardView(matchedGeometryID: id) {
                                            SimpsonsCharacterCardContent(character: character, matchedGeometryID: id)
                                        }
                                        .matchedGeometryEffect(id: id + "wholecard", in: namespace)
                                        .padding(.horizontal, horizontalPadding)
                                    }
                                    .buttonStyle(PushButton())
                                }
                            }
                            
                            Spacer()
                        }
                    }
                    
                    // Links
                    
                    ForEach(characters, id: \.id) { character in
                        let horizontalID = character.id + "horizontal"
                        let verticalID = character.id + "vertical"
                        
                        TransitionLink(
                            viewMakerID: horizontalID,
                            transitionWrapperID: horizontalID,
                            isActive: horizontalBinding(for: character),
                            transitionStyle: horizontalTransitionStyle,
                            showsDefaultCloseButton: false
                        ) { closeAction in
                            SimpsonsCharacterDetail(character: character, matchedGeometryID: horizontalID, closeAction: closeAction)
                        }
                        
                        TransitionLink(
                            viewMakerID: verticalID,
                            transitionWrapperID: verticalID,
                            isActive: verticalBinding(for: character),
                            transitionStyle: verticalTransitionStyle,
                            showsDefaultCloseButton: false
                        ) { closeAction in
                            SimpsonsCharacterDetail(character: character, matchedGeometryID: verticalID, closeAction: closeAction)
                        }
                    }
                    
                    if hideTabBar {
                        Color.clear
                            .toolbar(.hidden, for: .tabBar)
                    }
                }
            }
        }
    }
    
    func showHorizontal(character: SimpsonsCharacter) {
        hideTabBar = true
        activeHorizontalCharacter = character
    }
    
    func showVertical(character: SimpsonsCharacter) {
        hideTabBar = true
        activeVerticalCharacter = character
    }
    
    func horizontalBinding(for character: SimpsonsCharacter) -> Binding<Bool> {
        Binding<Bool>(
            get: {
                activeHorizontalCharacter?.id == character.id
            },
            set: {
                if $0 == false {
                    withAnimation(.transitionRemove) {
                        activeHorizontalCharacter = nil
                    }
                }
            }
        )
    }
    
    func verticalBinding(for character: SimpsonsCharacter) -> Binding<Bool> {
        Binding<Bool>(
            get: {
                activeVerticalCharacter?.id == character.id
            },
            set: {
                if $0 == false {
                    withAnimation(.transitionRemove) {
                        activeVerticalCharacter = nil
                    }
                }
            }
        )
    }
}

struct CardListView_Previews: PreviewProvider {
    static var previews: some View {
        CardListView()
    }
}
