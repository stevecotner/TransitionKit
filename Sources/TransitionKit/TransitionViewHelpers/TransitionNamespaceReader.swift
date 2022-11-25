//
//  TransitionNamespaceReader.swift
//  TransitionKit
//
//  Created by Stephen Cotner on 11/14/22.
//

import SwiftUI

struct TransitionNamespaceReader<Content>: View where Content: View {
    var content: (Namespace.ID) -> Content
    
    @EnvironmentObject private var transitionModel: TransitionModel
    @Namespace private var placeholderNamespace
    
    var body: some View {
        content(transitionModel.namespace ?? placeholderNamespace)
    }
}

struct TransitionNamespaceReader_Previews: PreviewProvider {
    static var previews: some View {
        TransitionNamespaceReader(content: { _ in EmptyView() })
    }
}
