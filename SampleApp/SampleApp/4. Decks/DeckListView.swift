//
//  DeckListView.swift
//  SampleApp
//
//  Created by Stephen Cotner on 11/23/22.
//

import SwiftUI
import TransitionKit

struct DeckListView: View {
    @State var isGermanDeckExpanded = false
    @State private var hideTabBar = false
    
    let germanNouns = GermanNoun.makeNouns()
    let horizontalPadding: CGFloat = 22
    
    var body: some View {
        TransitionView { namespace in
            ZStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 30) {
                        Text("Decks")
                            .padding(.horizontal, horizontalPadding)
                            .padding(.top, 20)
                            .padding(.bottom, -10)
                            .font(.title.bold())
                        
                        Text("Tap the card deck to show all of its cards. When you close it, the animation is tuned so that you'll see the fourth, fifth, and sixth cards fold under the deck. The rest of the cards fade away.")
                            .padding(.horizontal, horizontalPadding)
                            
                        // German Deck
                        TransitionWrapper(id: "german") {
                            ClosedCardDeck(
                                matchedGeometryID: "german",
                                title: "German Nouns",
                                items: germanNouns,
                                tapAction: {
                                    hideTabBar = true
                                    isGermanDeckExpanded = true
                                },
                                cardContent: { entry in
                                    GermanCardContent(entry: entry)
                                }
                            )
                            .padding(.horizontal, horizontalPadding)
                        }
                        
                        Text("The next deck goes two levels in: first it expands to show all its cards, and then each individual card can expand to show its own detail. Both transitions rely on the same top-level TransitionView.")
                            .padding(.horizontal, horizontalPadding)
                        
                        Text("(TODO)")
                            .padding(.horizontal, horizontalPadding)
                    }
                }
                
                // Link
                
                TransitionLink(
                    viewMakerID: "german",
                    transitionWrapperID: "german",
                    isActive: $isGermanDeckExpanded,
                    transitionStyle: .splitVertical,
                    showsDefaultCloseButton: true,
                    closeCompletion: { hideTabBar = false }
                ) { _ in
                    // We could have made this its own view, in a separate file, for more control.
                    OpenCardDeck(
                        matchedGeometryID: "german",
                        title: "German Nouns",
                        items: germanNouns,
                        cardTapAction: { _ in },
                        cardTransitionWrapperIDPrefix: "")
                    { entry in
                        GermanCardContent(entry: entry)
                    }
                }
                
                if hideTabBar {
                    Color.clear
                        .toolbar(.hidden, for: .tabBar)
                }
            }
            .background(Color.init(white: 0.99))
        }
    }
}

struct DeckListView_Previews: PreviewProvider {
    static var previews: some View {
        DeckListView()
    }
}
