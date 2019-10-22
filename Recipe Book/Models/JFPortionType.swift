//
//  JFPortionType.swift
//  Recipe Book
//
//  Created by Jonas Frey on 24.03.19.
//  Copyright © 2019 Jonas Frey. All rights reserved.
//

import Foundation

/// Represents a type of portion unit
enum JFPortionType: String, CaseIterable, Codable, Equatable, Hashable {
    case serving
    case piece
    case person
    
    /// Returns the human readable representation of the portion type in singular and plural form
    var humanReadable: (singular: String, plural: String) {
        switch self {
        case .serving:
            return ("serving", "servings")
        case .piece:
            return ("piece", "pieces")
        case .person:
            return ("person", "persons")
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
