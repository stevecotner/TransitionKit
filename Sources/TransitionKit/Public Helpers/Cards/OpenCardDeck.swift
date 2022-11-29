//
//  ExpandedCardDeck.swift
//  MatchedNavigation
//
//  Created by Stephen Cotner on 11/15/22.
//

import SwiftUI

public struct OpenCardDeck<Item: StringIdentifiable, CardContent>: View where CardContent: View {
    /// Used for matchedGeometryEffect
    let matchedGeometryID: String
    
    let title: String
    let items: [Item]
    let cardTapAction: (Item) -> Void
    let cardTransitionWrapperIDPrefix: String
    let cardContent: (Item) -> CardContent
    
    public var body: some View {
        TransitionNamespaceReader { namespace in
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    Spacer()
                        .frame(height: 10)
                    
                    HStack {
                        Text(title)
                            .id(matchedGeometryID + "CardDeckTitle\(title)")
                            .matchedGeometryEffect(id: matchedGeometryID + "CardDeckTitle\(title)", in: namespace)
                            .font(.title2.bold())
                        Spacer(minLength: 0)
                    }
                        .padding(.horizontal, 20)
                    
                    ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                        // Each card is in a transition wrapper.
                        // That's just in case we want to expand to yet another view.
                        // TransitionWrappers remove their content from the hierarchy when the content's mate is expanded.
                        TransitionWrapper(id: cardTransitionWrapperIDPrefix + item.id) {
                            Button {
                                cardTapAction(item)
                            } label: {
                                CardView(
                                    cornerRadius: 12,
                                    matchedGeometryID: matchedGeometryID + item.id) {
                                        VStack(alignment: .leading) {
                                            cardContent(item)
                                        }
                                    }
                                    .matchedGeometryEffect(id: matchedGeometryID + "wholecard" + item.id, in: namespace)
                                    .padding(.horizontal, 20)
                                
                            }
                            .buttonStyle(PushButton())
                            .accentColor(.black)
                        }
                        .zIndex(Double(items.count - index))
                    }
                }
            }
            .background(Color.init(white: 0.96))
        }
    }
}

struct OpenCardDeck_Previews: PreviewProvider {
    struct Item: StringIdentifiable {
        var id = UUID().uuidString
        var title: String
        var description: String
    }
    
    static let items: [Item] = [Item(title: "Hi", description: "desc")]
    static var previews: some View {
        OpenCardDeck(
            matchedGeometryID: "Deck",
            title: "Deck",
            items: items,
            cardTapAction: { _ in },
            cardTransitionWrapperIDPrefix: "",
            cardContent: { item in
                Text(item.title)
            }
        )
    }
}
