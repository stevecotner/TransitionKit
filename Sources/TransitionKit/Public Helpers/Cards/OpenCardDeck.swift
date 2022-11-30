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
    let cardTransitionWrapperIDPrefix: String?
    let cardContent: (Item) -> CardContent
    
    public init(
        matchedGeometryID: String,
        title: String,
        items: [Item],
        cardTapAction: @escaping (Item) -> Void,
        cardTransitionWrapperIDPrefix: String? = nil,
        cardContent: @escaping (Item) -> CardContent
    ) {
        self.matchedGeometryID = matchedGeometryID
        self.title = title
        self.items = items
        self.cardTapAction = cardTapAction
        self.cardTransitionWrapperIDPrefix = cardTransitionWrapperIDPrefix
        self.cardContent = cardContent
    }
    
    public var body: some View {
        TransitionNamespaceReader { namespace in
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    Spacer()
                        .frame(height: 30)
                    
                    HStack {
                        Text(title)
                            .matchedGeometryEffect(id: matchedGeometryID + "CardDeckTitle\(title)", in: namespace)
                            .minimumScaleFactor(0.1)
                            .font(.title2.bold())
                        Spacer(minLength: 0)
                    }
                    .matchedGeometryEffect(id: matchedGeometryID + "CardDeckTitleStack\(title)", in: namespace)
                        .padding(.horizontal, 20)
                    
                    ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                        // Each card is in a transition wrapper.
                        // That's just in case we want to expand to yet another view.
                        // TransitionWrappers remove their content from the hierarchy when the content's mate is expanded.
                        TransitionWrapper(id: (cardTransitionWrapperIDPrefix ?? matchedGeometryID + "cardwrapper") + item.id) {
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
