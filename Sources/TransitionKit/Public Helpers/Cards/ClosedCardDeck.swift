//
//  ClosedCardDeck.swift
//  MatchedNavigation
//
//  Created by Stephen Cotner on 11/15/22.
//

import SwiftUI

public struct ClosedCardDeck<Item: StringIdentifiable, CardContent>: View where CardContent: View {
    /// Used for matchedGeometryEffect
    let matchedGeometryID: String
    
    let title: String
    let items: [Item]
    let tapAction: () -> Void
    let cardContent: (Item) -> CardContent
    
    public init(
        matchedGeometryID: String,
        title: String,
        items: [Item],
        tapAction: @escaping () -> Void,
        cardContent: @escaping (Item) -> CardContent)
    {
        self.matchedGeometryID = matchedGeometryID
        self.title = title
        self.items = items
        self.tapAction = tapAction
        self.cardContent = cardContent
    }
    
    public var body: some View {
        return TransitionNamespaceReader { namespace in
            VStack(alignment: .leading) {
                HStack {
                    Text(title)
                        .matchedGeometryEffect(id: matchedGeometryID + "CardDeckTitle\(title)", in: namespace)
                        .minimumScaleFactor(0.1)
                        .font(.title2.bold())
                    Spacer(minLength: 0)
                }
                .matchedGeometryEffect(id: matchedGeometryID + "CardDeckTitleStack\(title)", in: namespace)
                
                Button {
                    tapAction()
                } label: {
                    cards()
                        .accessibilityElement(children: .ignore)
                        .accessibilityLabel("\(title) Card Deck")
                }
                .buttonStyle(PushButton())
                .accentColor(.black)
            }
        }
        
        
        func cards() -> some View {
            return TransitionNamespaceReader { namespace in
                ZStack(alignment: .bottom) {
                    // Buried Cards
                    if items.count > 1 {
                        ForEach(1..<min(50, items.count), id: \.self) { index in
                            let item = items[index]
                            
                            DummyCardView(matchedGeometryID: matchedGeometryID + item.id, shadowOpacity: shadowOpacity(for: index))
                                .matchedGeometryEffect(id: matchedGeometryID + "wholecard" + item.id, in: namespace)
                                .padding(.horizontal, padding(for: index))
                                .offset(y: offset(for: index))
                                .opacity(opacity(for: index))
                                .zIndex(Double(items.count - index))
                        }
                    }
                    
                    // Top card
                    if let first = items.first {
                        CardView(
                            cornerRadius: 12,
                            matchedGeometryID: matchedGeometryID + first.id) {
                                VStack(alignment: .leading) {
                                    cardContent(first)
                                }
                            }
                            .matchedGeometryEffect(id: matchedGeometryID + "wholecard" + first.id, in: namespace)
                            .padding(.horizontal, 0)
                            .zIndex(Double(items.count))
                    }
                }
                .padding(.bottom, items.count > 2 ? 30 : items.count > 1 ? 20 : 10)
            }
        }
        
        func shadowOpacity(for index: Int) -> CGFloat {
            index < 2 ? 0.2 :
            index == 2 ? (items.count > 3 ? 0.13 : 0.2) :
            index == 3 ? (items.count > 4 ? 0.06 : 0.09) :
            index == 4 ? (items.count > 4 ? 0.03 : 0.04) :
            index == 5 ? 0.02 :
            0.001
        }
        
        func padding(for index: Int) -> CGFloat {
            CGFloat((min(6, index)) * 10)
        }
        
        func offset(for index: Int) -> CGFloat {
            index == 1 ? 10 :
            index == 2 ? 20 :
            index == 3 ? 20.02 :
            index == 4 ? 20.03 :
            index == 5 ? 20.04 :
            20.04
        }
        
        func opacity(for index: Int) -> CGFloat {
            index < 6 ? 1 :
            0.001
        }
    }
}

struct ClosedCardDeck_Previews: PreviewProvider {
    struct Item: StringIdentifiable {
        var id = UUID().uuidString
        var title: String
        var description: String
    }
    
    static let items: [Item] = [Item(title: "Hi", description: "desc")]
    
    static var previews: some View {
        ClosedCardDeck(
            matchedGeometryID: "Deck",
            title: "Deck",
            items: items,
            tapAction: {},
            cardContent: { item in
                Text(item.title)
            }
        )
    }
}
