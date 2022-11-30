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
    
    let germanEntries = GermanEntry.makeEntries()
    
    var body: some View {
        TransitionView { namespace in
            ZStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 30) {
                        Text("Decks")
                            .padding(.horizontal, 22)
                            .padding(.top, 20)
                            .font(.title.bold())
                        
                        // German Deck
                        TransitionWrapper(id: "german") {
                            ClosedCardDeck(
                                matchedGeometryID: "german",
                                title: "German",
                                items: germanEntries,
                                tapAction: {
                                    hideTabBar = true
                                    isGermanDeckExpanded = true
                                },
                                cardContent: { entry in
                                    GermanCardContent(entry: entry)
                                }
                            )
                            .padding(.horizontal, 22)
                        }
                        
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
                        OpenCardDeck(
                            matchedGeometryID: "german",
                            title: "German",
                            items: germanEntries,
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
            .background(Color.init(white: 0.97))
        }
    }
}

struct DeckListView_Previews: PreviewProvider {
    static var previews: some View {
        DeckListView()
    }
}
