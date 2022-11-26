//
//  SimpsonsCharacterDetail.swift
//  SampleApp
//
//  Created by Stephen Cotner on 11/26/22.
//

import SwiftUI
import TransitionKit

struct SimpsonsCharacterDetail: View {
    let character: SimpsonsCharacter
    let matchedGeometryID: String
    
    @State var showDescription = false
    
    var body: some View {
        GeometryReader { geometry in
            TransitionNamespaceReader { namespace in
                CardView(
                    cornerRadius: 0,
                    matchedGeometryID: matchedGeometryID
                ) {
                    ScrollView {
                        VStack(spacing: 0) {
                            Spacer()
                                .frame(height: geometry.safeAreaInsets.top + 20)
                            
                            Image(character.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .layoutPriority(2)
                                .matchedGeometryEffect(id: matchedGeometryID + "image", in: namespace)
                            
                            HStack {
                                Text(character.name)
                                    .font(.title3.bold())
                                    .layoutPriority(2)
                                Spacer()
                            }
                            .matchedGeometryEffect(id: matchedGeometryID + "name", in: namespace)
                            .padding(6)
                            .padding(.top, 16)
                            
                            if showDescription {
                                HStack {
                                    Text(character.description)
                                        .layoutPriority(1)
                                    Spacer()
                                }
                                .matchedGeometryEffect(id: matchedGeometryID + "additionalcontent", in: namespace)
                                
                                .padding(6)
                                .padding(.top, 6)
                            }
                            
                            Spacer(minLength: 0)
                            
                            Spacer()
                                .frame(height: geometry.safeAreaInsets.top + 40)
                        }
                        .matchedGeometryEffect(id: matchedGeometryID + "content", in: namespace)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.horizontal, 20)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .ignoresSafeArea(edges: [.top, .bottom])
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                withAnimation(.easeIn) {
                    showDescription = true
                }
            }
        }
    }
}

struct SimpsonsCharacterDetail_Previews: PreviewProvider {
    static var previews: some View {
        SimpsonsCharacterDetail(character: SimpsonsCharacter(name: "Bart", imageName: "bart", description: "..."), matchedGeometryID: "1")
    }
}
