//
//  CartView.swift
//  SampleApp
//
//  Created by Stephen Cotner on 11/23/22.
//

import SwiftUI
import TransitionKit

struct CartView: View {
    @State var showCheckout = false
    @State var transitionStyle: TransitionStyle = .splitVertical
    
    let horizontalPadding: CGFloat = 22
    
    var body: some View {
        TransitionView { namespace in
            ZStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Text("Button")
                                .font(.title.bold())
                            Spacer()
                        }
                        .padding(.horizontal, horizontalPadding)
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                        
                        Text(
                            """
                            Tap the "Checkout" button to see it take over the whole screen. Its title becomes the title of the new screen. Other elements appear as screen expands.
                            """)
                        .padding(.horizontal, horizontalPadding)
                        .padding(.bottom, 20)
                        
                        TransitionStylePicker(transitionStyle: $transitionStyle)
                            .padding(.horizontal, horizontalPadding)
                        
                        Spacer()
                    }
                }
                .safeAreaInset(edge: .bottom) {
                    TransitionWrapper(id: "checkout") {
                        Button {
                            showCheckout = true
                        } label: {
                            ZStack(alignment: .trailing) {
                                VStack {
                                    HStack {
                                        Spacer()
                                        Text("Checkout")
                                            .matchedGeometryEffect(id: "checkouttitle", in: namespace)
                                            .minimumScaleFactor(0.1)
                                            .font(.title2.bold())
                                            .foregroundColor(.black)
                                            .padding(.vertical, 12)
                                            .padding(.horizontal, 40)
                                            .background(
                                                RoundedRectangle(cornerRadius: 30, style: SwiftUI.RoundedCornerStyle.continuous)
                                                    .stroke(style: SwiftUI.StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                                                    .matchedGeometryEffect(id: "checkoutstroke", in: namespace)
                                            )
                                            .padding(.horizontal, 20)
                                            .padding(.bottom, 20)
                                        Spacer()
                                    }
                                    VStack {
                                        Text("")
                                    }
                                    .matchedGeometryEffect(id: "checkoutcontents", in: namespace)
                                }
                                
                                HStack() {
                                    Button {
                                    } label: {
                                    }
                                    .matchedGeometryEffect(id: "checkoutfloattop", in: namespace)
                                    .frame(height: 0)
                                }
                                .allowsHitTesting(false)
                                
                                VStack(alignment: .leading) {
                                    Spacer()
                                    HStack {
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
                                        .frame(height: 0)
                                        .clipped()
                                        Spacer()
                                    }
                                }
                                .allowsHitTesting(false)
                                .frame(height: 0)
                            }
                        }
                            .buttonStyle(PushButton())
                    }
                }
                
                // Link
                
                TransitionLink(
                    viewMakerID: "checkout",
                    transitionWrapperID: "checkout",
                    isActive: $showCheckout,
                    transitionStyle: transitionStyle,
                    showsDefaultCloseButton: false)
                { closeAction in
                    CheckoutView(closeAction: closeAction)
                }
            }
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
