//
//  JFUnit.swift
//  Recipe Book
//
//  Created by Jonas Frey on 25.03.19.
//  Copyright © 2019 Jonas Frey. All rights reserved.
//

import Foundation

/// Represents a type of ingredient unit
enum JFUnit: String, CaseIterable, Codable, Equatable, Hashable {
    case none
    case piece
    case kilogram
    case gram
    case liter
    case milliliter
    case tablespoon
    case teaspoon
    case stem
    // Packung
    case box
    // Tasse
    case cup
    case pinch
    case dice
    case leaf
    case jar
    
    var humanReadable: (singular: String, plural: String) {
        switch self {
        case .none:
            return (JFLiterals.noUnit, JFLiterals.noUnit)
        case .piece:
            return ("piece", "pieces")
        case .kilogram:
            return ("kg", "kg")
        case .gram:
            return ("g", "g")
        case .liter:
            return ("l", "l")
        case .milliliter:
            return ("ml", "ml")
        case .tablespoon:
            return ("tbsp", "tbsp")
        case .teaspoon:
            return ("tsp", "tsp")
        case .stem:
            return ("stem", "stems")
        case .box:
            return ("box", "boxes")
        case .cup:
            return ("cup", "cups")
        case .pinch:
            return ("pinch", "pinches")
        case .dice:
            return ("dice", "dices")
        case .leaf:
            return ("leaf", "leaves")
        case .jar:
            return ("jar", "jars")
        }
    }
    
    /// Returns the correct human readable form
    /// Important: Also returns the singular form for amount 0!
    /// - Parameter amount: The amount of the unit
    /// - Returns: The singular form, if the amount equals 1, the plural form otherwise
    func humanReadable(_ amount: Int) -> String {
        return amount == 1 ? self.humanReadable.singular : self.humanReadable.plural
    }
    
    /// Returns the correct human readable form
    /// Important: Also returns the singular form for amount 0! 
    /// - Parameter amount: The amount of the unit
    /// - Parameter digits: The number of fraction digits to round to, before checking for singular/plural
    /// - Returns: The singular form, if the amount, rounded to the given number of fraction digits, equals 1, the plural form otherwise
    func humanReadable(_ amount: Double, digits: Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = digits
        let amountStr = formatter.string(from: NSNumber(floatLiteral: amount))!
        if amountStr == "0" || amountStr == "1" {
            return self.humanReadable.singular
        }
        return self.humanReadable.plural
    }
}
