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
    
    var body: some View {
        TransitionView { namespace in
            ZStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Button")
                            .font(.title.bold())
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                            .padding(.bottom, 10)
                        
                        Text(
                            """
                            In this example, a button grows to take over the whole screen. Its title becomes the title of the new screen.
                            """)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 10)
                        
                        TransitionStylePicker(transitionStyle: $transitionStyle)
                            .padding(.horizontal, 20)
                        
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
                                        Text("Checkout")
                                            .minimumScaleFactor(0.1)
                                            .matchedGeometryEffect(id: "checkouttitle", in: namespace)
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
                    .frame(height: 0)
                    .clipped()
                }
                .allowsHitTesting(false)
                .padding(.bottom, 40)
            }
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
