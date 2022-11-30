//
//  GermanNoun.swift
//  SampleApp
//
//  Created by Stephen Cotner on 11/29/22.
//

import Foundation
import TransitionKit

struct GermanNoun: StringIdentifiable {
    let id: String = UUID().uuidString
    let german: String
    let gender: Gender
    let english: String
    
    enum Gender: String {
        case feminine = "feminine"
        case masculine = "masculine"
        case neuter = "neuter"
    }
}

extension GermanNoun {
    static func makeNouns() -> [GermanNoun] {
        [
            GermanNoun(
                german: "der Vater",
                gender: .masculine,
                english: "father"
            ),
            
            GermanNoun(
                german: "der Sohn",
                gender: .masculine,
                english: "son"
            ),
            
            GermanNoun(
                german: "der Bruder",
                gender: .masculine,
                english: "brother"
            ),
            
            GermanNoun(
                german: "der Onkel",
                gender: .masculine,
                english: "uncle"
            ),
            
            GermanNoun(
                german: "der Großvater",
                gender: .masculine,
                english: "grandfather"
            ),
            
            GermanNoun(
                german: "die Mutter",
                gender: .feminine,
                english: "mother"
            ),
            
            GermanNoun(
                german: "die Tochter",
                gender: .feminine,
                english: "daughter"
            ),
            
            GermanNoun(
                german: "die Schwester",
                gender: .feminine,
                english: "sister"
            ),
            
            GermanNoun(
                german: "die Tante",
                gender: .feminine,
                english: "aunt"
            ),
            
            GermanNoun(
                german: "die Eltern",
                gender: .feminine,
                english: "parents"
            ),
            
            GermanNoun(
                german: "der Mann",
                gender: .masculine,
                english: "man, husband"
            ),
            
            GermanNoun(
                german: "die Frau",
                gender: .feminine,
                english: "woman, wife"
            ),
            
            GermanNoun(
                german: "die Kinder",
                gender: .feminine,
                english: "children"
            ),
            
            GermanNoun(
                german: "die Großmutter",
                gender: .feminine,
                english: "grandmother"
            ),
            
            GermanNoun(
                german: "der Ball",
                gender: .masculine,
                english: "ball"
            ),
            
            GermanNoun(
                german: "die Schule",
                gender: .feminine,
                english: "school"
            ),
            
            GermanNoun(
                german: "das Kind",
                gender: .neuter,
                english: "child"
            ),
            
            GermanNoun(
                german: "das Glas",
                gender: .neuter,
                english: "glass"
            ),
            
            GermanNoun(
                german: "die Suppe",
                gender: .feminine,
                english: "soup"
            ),
        ]
    }
}
