//
//  JFIngredient.swift
//  Recipe Book
//
//  Created by Jonas Frey on 24.03.19.
//  Copyright © 2019 Jonas Frey. All rights reserved.
//

import Foundation

/// Represents an ingredient in a recipe
struct JFIngredient: Codable, Equatable, Hashable, Identifiable {
    
    let id: UUID = UUID()
    var amount: Double
    var unit: JFUnit
    var name: String
    
    init() {
        self.init(amount: 0, unit: .none, name: "")
    }
    
    init(amount: Double, unit: JFUnit, name: String) {
        self.amount = amount
        self.unit = unit
        self.name = name
    }
}
