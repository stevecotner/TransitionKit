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
    @State var activeCharacter: SimpsonsCharacter?
    let transitionStyle: TransitionStyle = .split
    
    var body: some View {
        TransitionView { namespace in
            ScrollView {
                ZStack {
                    VStack(alignment: .leading, spacing: 30) {
                        Text("Cards")
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                            .font(.title.bold())
                        
                        ForEach(characters, id: \.id) { character in
                            let id = character.id
                            
                            TransitionWrapper(id: id) {
                                Button {
                                    action(for: character)
                                } label: {
                                    CardView(matchedGeometryID: id) {
                                        SimpsonsCharacterCardContent(character: character, matchedGeometryID: id)
                                    }
                                    .padding(.horizontal, 30)
                                }
                                .buttonStyle(PushButton())
                            }
                        }
                        
                        Spacer()
                    }
                    
                    // Links
                    
                    ForEach(characters, id: \.id) { character in
                        let id = character.id
                        
                        TransitionLink(
                            viewMakerID: id,
                            transitionWrapperID: id,
                            isActive: binding(for: character),
                            transitionStyle: transitionStyle,
                            showsXButton: false
                        ) { unwindAction in
                            SimpsonsCharacterDetail(character: character, matchedGeometryID: id, unwindAction: unwindAction)
                        }
                    }
                }
            }
        }
    }
    
    func action(for character: SimpsonsCharacter) {
        activeCharacter = character
    }
    
    func binding(for character: SimpsonsCharacter) -> Binding<Bool> {
        Binding<Bool>(
            get: {
                activeCharacter?.id == character.id
            },
            set: {
                if $0 == false {
                    withAnimation(.transitionRemove) {
                        activeCharacter = nil
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
