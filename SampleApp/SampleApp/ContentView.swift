//
//  ContentView.swift
//  SampleApp
//
//  Created by Stephen Cotner on 11/23/22.
//

import SwiftUI
import TransitionKit

struct ContentView: View {
    
    init() {
        // This solves a weird bug where a tab's content covers the tab bar, if the content ignores safe areas.
        // See: https://developer.apple.com/forums/thread/690563
        UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance.init(idiom: .unspecified)
    }
    
    var body: some View {
        TabView {
            BasicView()
                .tabItem {
                    Label("Basic", systemImage: "1.square")
                }
            
            CartView()
                .tabItem {
                    Label("Button", systemImage: "capsule.inset.filled")
                }
            
            CardListView()
                .tabItem {
                    Label("Cards", systemImage: "person.crop.square")
                }
            
            DeckListView()
                .tabItem {
                    Label("Decks", systemImage: "rectangle.stack")
                }
        }
        .accentColor(Color(UIColor.systemPink))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
