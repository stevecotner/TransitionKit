//
//  BasicView.swift
//  SampleApp
//
//  Created by Stephen Cotner on 11/23/22.
//

import SwiftUI
import TransitionKit

struct BasicView: View {
    @State var is1Active = false
    @State var is2Active = false
    @State var is3Active = false
    @State var is4Active = false
    @State var is5Active = false
    
    @State var transitionStyle: TransitionStyle = .fade
    
    var body: some View {
        TransitionView { namespace in
            VStack(alignment: .leading, spacing: 0) {
                Text("Basic")
                    .font(.title.bold())
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                
                TransitionStylePicker(transitionStyle: $transitionStyle)
                    .padding(.horizontal, 20)
                
                Spacer()
                
                VStack(alignment: .center, spacing: 20) {
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
                            VStack(alignment: .leading) {
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

struct BasicView_Previews: PreviewProvider {
    static var previews: some View {
        BasicView()
    }
}
