//
//  StringIdentifiable.swift
//  SampleApp
//
//  Created by Stephen Cotner on 11/29/22.
//

import Foundation

public protocol StringIdentifiable: Identifiable {
    var id: String { get }
}
