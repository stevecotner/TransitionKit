//
//  ContentView.swift
//  SampleApp
//
//  Created by Stephen Cotner on 11/23/22.
//

import SwiftUI
import TransitionKit

struct ContentView: View {
    
    var body: some View {
        TabView {
            SimpleView()
                .tabItem {
                    Text("Simple A")
                }
            
            SimpleViewWithSmartBinding()
                .tabItem {
                    Text("Simple B")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
