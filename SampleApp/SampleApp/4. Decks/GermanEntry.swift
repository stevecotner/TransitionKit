//
//  GermanEntry.swift
//  SampleApp
//
//  Created by Stephen Cotner on 11/29/22.
//

import Foundation
import TransitionKit

struct GermanEntry: StringIdentifiable {
    let id: String = UUID().uuidString
    let german: String
    let english: String
}

extension GermanEntry {
    static func makeEntries() -> [GermanEntry] {
        [
            GermanEntry(
                german: "der Vater",
                english: "father"
            ),
            
            GermanEntry(
                german: "der Sohn",
                english: "son"
            ),
            
            GermanEntry(
                german: "der Bruder",
                english: "brother"
            ),
            
            GermanEntry(
                german: "der Onkel",
                english: "uncle"
            ),
            
            GermanEntry(
                german: "der Großvater",
                english: "grandfather"
            ),
            
            GermanEntry(
                german: "die Mutter",
                english: "mother"
            ),
            
            GermanEntry(
                german: "die Tochter",
                english: "daughter"
            ),
            
            GermanEntry(
                german: "die Schwester",
                english: "sister"
            ),
            
            GermanEntry(
                german: "die Tante",
                english: "aunt"
            ),
            
            GermanEntry(
                german: "die Eltern",
                english: "parents"
            ),
            
            GermanEntry(
                german: "der Mann",
                english: "man, husband"
            ),
            
            GermanEntry(
                german: "die Frau",
                english: "woman, wife"
            ),
            
            GermanEntry(
                german: "die Kinder",
                english: "children"
            ),
            
            GermanEntry(
                german: "die Großmutter",
                english: "grandmother"
            )
        ]
    }
}
