//
//  GermanCardContent.swift
//  SampleApp
//
//  Created by Stephen Cotner on 11/29/22.
//

import SwiftUI

struct GermanCardContent: View {
    let entry: GermanEntry
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(entry.german).bold()
                Text(entry.english)
            }
            Spacer()
        }
        .padding(20)
    }
}

struct GermanCardContent_Previews: PreviewProvider {
    static var previews: some View {
        GermanCardContent(entry: .init(german: "Ja", english: "Yes"))
    }
}
