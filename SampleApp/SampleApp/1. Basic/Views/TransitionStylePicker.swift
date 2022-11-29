//
//  TransitionStylePicker.swift
//  SampleApp
//
//  Created by Stephen Cotner on 11/25/22.
//

import SwiftUI
import TransitionKit

struct TransitionStylePicker: View {
    @Binding var transitionStyle: TransitionStyle
    
    var body: some View {
        HStack(alignment: .top) {
            Text("Choose a style:")
                .padding(.top, 10)
                .padding(.bottom, -8)
            
            Picker("Transition Style", selection: $transitionStyle) {
                Text("Fade").tag(TransitionStyle.fade)
                Text("Split Vertically").tag(TransitionStyle.splitVertical)
            }
            .padding(.top, 3)
        }
        .padding(.top, -10)
        .padding(.bottom, 4)
        .padding(.trailing, 10)
    }
}

struct TransitionStylePicker_Previews: PreviewProvider {
    static var previews: some View {
        TransitionStylePicker(transitionStyle: .constant(.splitVertical))
    }
}
