//
//  DeckListView.swift
//  SampleApp
//
//  Created by Stephen Cotner on 11/23/22.
//

import SwiftUI
import TransitionKit

struct DeckListView: View {
    
    @State private var hideTabBar = false
    
    var body: some View {
        GeometryReader { geometry in
            TransitionView { namespace in
                ZStack {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 30) {
                            Text("Decks")
                                .padding(.horizontal, 30)
                                .padding(.top, 20)
                                .font(.title.bold())
                            
                            //
                            
                            Spacer()
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
}

struct DeckListView_Previews: PreviewProvider {
    static var previews: some View {
        DeckListView()
    }
}
