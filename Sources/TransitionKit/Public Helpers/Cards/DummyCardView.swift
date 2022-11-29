//
//  DummyCardView.swift
//  MatchedNavigation
//
//  Created by Stephen Cotner on 11/15/22.
//

import SwiftUI

public struct DummyCardView: View {
    /// used for matchedGeometryEffect
    let matchedGeometryID: String
    let cornerRadius: CGFloat
    let shouldShowShadow: Bool
    
    public init(matchedGeometryID: String, cornerRadius: CGFloat = 14, shouldShowShadow: Bool) {
        self.matchedGeometryID = matchedGeometryID
        self.cornerRadius = cornerRadius
        self.shouldShowShadow = shouldShowShadow
    }
    
    public var body: some View {
        TransitionNamespaceReader { namespace in
            Rectangle()
                .fill(Color.clear)
                .frame(height: 20) // Dummy cards aren't very tall!
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                .padding(.top, 22)
                .padding(.bottom, 24)
                .background(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(shouldShowShadow ? 0.2 : 0), radius: 18, x: 0, y: 3)
                        .matchedGeometryEffect(id: matchedGeometryID + "card" + "background", in: namespace)
                )
        }
    }
}

struct DummyCardView_Previews: PreviewProvider {
    static var previews: some View {
        DummyCardView(matchedGeometryID: "hi", shouldShowShadow: true)
    }
}
