//
//  SimpleView.swift
//  SampleApp
//
//  Created by Stephen Cotner on 11/23/22.
//

import SwiftUI
import TransitionKit

struct SimpleView: View {
    @State var is1Active = false
    @State var is2Active = false
    @State var is3Active = false
    @State var is4Active = false
    @State var is5Active = false
    
    @State var transitionStyle: TransitionStyle = .split
    
    var body: some View {
        TransitionView { namespace in
            VStack {
                Text("Simple Transitions A")
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
        switch number {
        case 1:
            is1Active = true
            
        case 2:
            is2Active = true
            
        case 3:
            is3Active = true
            
        case 4:
            is4Active = true
            
        case 5:
            is5Active = true
            
        default:
            return
        }
    }
    
    func binding(for number: Int) -> Binding<Bool> {
        switch number {
        case 1:
            return $is1Active
            
        case 2:
            return $is2Active
            
        case 3:
            return $is3Active
            
        case 4:
            return $is4Active
            
        case 5:
            return $is5Active
            
        default:
            return .constant(false)
        }
    }
}

struct SimpleView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleView()
    }
}
