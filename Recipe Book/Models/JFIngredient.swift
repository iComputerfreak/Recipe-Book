//
//  JFIngredient.swift
//  Recipe Book
//
//  Created by Jonas Frey on 24.03.19.
//  Copyright © 2019 Jonas Frey. All rights reserved.
//

import Foundation

/// Represents an ingredient in a recipe
struct JFIngredient: Codable, Equatable, Hashable {
    var amount: Double
    var unit: JFUnitType
    var name: String
}
