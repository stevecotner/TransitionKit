//
//  SimpsonsCharacterCardContent.swift
//  SampleApp
//
//  Created by Stephen Cotner on 11/26/22.
//

import SwiftUI
import TransitionKit

struct SimpsonsCharacterCardContent: View {
    let character: SimpsonsCharacter
    let matchedGeometryID: String
    
    var body: some View {
        TransitionNamespaceReader { namespace in
            VStack(alignment: .leading) {
                Image(character.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .layoutPriority(2)
                    .matchedGeometryEffect(id: matchedGeometryID + "image", in: namespace)
                
                HStack {
                    Text(character.name)
                        .layoutPriority(2)
                        .foregroundColor(.black)
                        .font(.title3.bold())
                    Spacer()
                }
                    .matchedGeometryEffect(id: matchedGeometryID + "name", in: namespace)
                    .padding(6)
                    .padding(.top, 6)
                
                HStack(spacing: 0) {
                    Spacer(minLength: 0)
                        .layoutPriority(0)
                }
                .matchedGeometryEffect(id: matchedGeometryID + "additionalcontent", in: namespace)
                .layoutPriority(1)
                .frame(height: 0)
                .opacity(0)
            }
            .matchedGeometryEffect(id: matchedGeometryID + "content", in: namespace)
            .accentColor(.black)
            .padding(20)
        }
    }
}

struct SimpsonsCharacterCardContent_Previews: PreviewProvider {
    static var previews: some View {
        SimpsonsCharacterCardContent(character: SimpsonsCharacter(name: "Bart", imageName: "bart", description: "..."), matchedGeometryID: "1")
    }
}
