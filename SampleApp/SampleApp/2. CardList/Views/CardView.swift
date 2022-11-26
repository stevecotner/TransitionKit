//
//  CardView.swift
//  SampleApp
//
//  Created by Stephen Cotner on 11/25/22.
//

import SwiftUI
import TransitionKit

struct CardView<Content>: View where Content: View {
    var cornerRadius: CGFloat = 14
    var matchedGeometryID: String
    var content: () -> Content
    
    var body: some View {
        TransitionNamespaceReader { namespace in
            content()
                .mask(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .matchedGeometryEffect(id: matchedGeometryID + "cardmask", in: namespace)
                )
                .background(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.25), radius: 16, y: 5)
                        .matchedGeometryEffect(id: matchedGeometryID + "cardshadow", in: namespace)
                )
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(matchedGeometryID: "id", content: { Text("hi") })
    }
}
