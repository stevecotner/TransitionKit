//
//  SimpleViewWithSmartBinding.swift
//  SampleApp
//
//  Created by Stephen Cotner on 11/23/22.
//

import SwiftUI
import TransitionKit

/**
 This view is the same as SimpleView,
 but it uses a single state property, `activeNumber`, for all selections.
 In order to do this, we have to create a smart binding.
 And in order for our transition animations to work properly, we need to apply
 the animation whent he smart binding gets and sets its properties.
 */

struct SimpleViewWithSmartBinding: View {
    @State var activeNumber: Int?
    @State var transitionStyle: TransitionStyle = .fade
    
    var body: some View {
        TransitionView { namespace in
            VStack {
                Text("Simple Transitions B")
                    .font(.title)
                
                TransitionStylePicker(transitionStyle: $transitionStyle)
                
                Spacer()
                
                ForEach(Array(1...5), id: \.self) { number in
                    let id = String(number)
                    
                    TransitionWrapper(id: id) {
                        Button {
                            action(for: number)
                        } label: {
                            Text(id)
                                .matchedGeometryEffect(id: id, in: namespace)
                        }
                    }
                }
                
                Spacer()
                
                // Links
                
                ForEach(Array(1...5), id: \.self) { number in
                    let id = String(number)
                    
                    TransitionLink(
                        viewMakerID: id,
                        transitionWrapperID: id,
                        isActive: binding(for: number),
                        transitionStyle: transitionStyle) { _ in
                            VStack {
                                Spacer()
                                    .frame(height: 20)
                                Text(id)
                                    .matchedGeometryEffect(id: id, in: namespace)
                                    .scaleEffect(2)
                                Spacer()
                            }
                        }
                }
            }
        }
    }
    
    func action(for number: Int) {
        activeNumber = number
    }
    
    func binding(for number: Int) -> Binding<Bool> {
        Binding<Bool>(
            get: {
                withAnimation(.transitionAdd) {
                    activeNumber == number
                }
            },
            set: {
                if $0 == false {
                    withAnimation(.transitionRemove) {
                        activeNumber = nil
                    }
                }
            }
        )
    }
}

struct SimpleViewWithSmartBinding_Previews: PreviewProvider {
    static var previews: some View {
        SimpleViewWithSmartBinding()
    }
}
