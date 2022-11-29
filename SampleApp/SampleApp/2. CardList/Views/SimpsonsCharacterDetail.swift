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
    let unwindAction: () -> Void
    
    @State private var showDescription = false
    
    var body: some View {
        GeometryReader { geometry in
            TransitionNamespaceReader { namespace in
                ZStack {
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
                                            .fixedSize(horizontal: false, vertical: true)
                                            .layoutPriority(2)
                                        Spacer()
                                    }
                                    .matchedGeometryEffect(id: matchedGeometryID + "additionalcontent", in: namespace)
                                    
                                    .padding(6)
                                    .padding(.top, 6)
                                    .transition(.opacity)
                                }
                                
                                Spacer(minLength: geometry.safeAreaInsets.bottom + 40)
                            }
                            .matchedGeometryEffect(id: matchedGeometryID + "content", in: namespace)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding(.horizontal, 20)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .matchedGeometryEffect(id: matchedGeometryID + "wholecard", in: namespace)
                    .ignoresSafeArea(edges: [.top, .bottom])
                    
                    // X-button
                    VStack {
                        HStack {
                            Spacer()
                            Button {
                                remove()
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 26)
                                    .foregroundColor(.black)
                            }
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 12)
                }
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
    
    func remove() {
        withAnimation(.transitionRemove) {
            showDescription = false
        }
        
        unwindAction()
        
        // Just in case the user asks to show the view again before it's really been removed.
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation(.easeIn) {
                showDescription = true
            }
        }
    }
}

struct SimpsonsCharacterDetail_Previews: PreviewProvider {
    static var previews: some View {
        SimpsonsCharacterDetail(
            character: SimpsonsCharacter(name: "Bart", imageName: "bart", description: "..."),
            matchedGeometryID: "1",
            unwindAction: {}
        )
    }
}
