//
//  CheckoutView.swift
//  SampleApp
//
//  Created by Stephen Cotner on 11/29/22.
//

import SwiftUI
import TransitionKit

struct CheckoutView: View {
    let closeAction: () -> Void
    
    var body: some View {
        TransitionNamespaceReader { namespace in
            ZStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Checkout")
                                .minimumScaleFactor(0.1)
                                .matchedGeometryEffect(id: "checkouttitle", in: namespace)
                                .font(.title.bold())
                                .foregroundColor(.black)
                                .padding(.vertical, 12)
                            Spacer()
                        }
                        
                        VStack(alignment: .leading, spacing: 20) {
                            Text("2 Items").bold()
                            
                            Text("Pair of shoes: $50")
                            
                            Text("Shirt: $30")
                            
                            Divider()
                            
                            Text("Total: $80")
                                
                            
                            Spacer()
                        }
                        .minimumScaleFactor(0.1)
                        .matchedGeometryEffect(id: "checkoutcontents", in: namespace)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity)
                }
                .background(
                    RoundedRectangle(cornerRadius: 20, style: SwiftUI.RoundedCornerStyle.continuous)
                        .stroke(style: SwiftUI.StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                        .matchedGeometryEffect(id: "checkoutstroke", in: namespace)
                )
                .padding(10)
                .clipped()
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                
                // Close Button
                VStack() {
                    HStack() {
                        Spacer()
                        Button {
                            closeAction()
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 26)
                                .foregroundColor(.black)
                                .padding(.vertical, 24)
                                .padding(.horizontal, 44)
                        }
                        .matchedGeometryEffect(id: "checkoutfloattop", in: namespace)
                    }
                    Spacer()
                }
                
                // Place Order Button
                VStack(alignment: .center) {
                    Spacer()
                    Button {
                        //
                    } label: {
                        Text("Place Order")
                            .minimumScaleFactor(0.1)
                            .font(.title3.bold())
                            .foregroundColor(.white)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 40)
                            .background(
                                RoundedRectangle(cornerRadius: 30, style: SwiftUI.RoundedCornerStyle.continuous)
                                    .fill(Color(UIColor.systemPink))
                                    .foregroundColor(.white)
                            )
                            .padding(.bottom, 60)
                            
                    }
                    .matchedGeometryEffect(id: "checkoutfloatbottom", in: namespace)
                }
            }
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(closeAction: {})
    }
}
