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
    
    func humanReadable(_ amount: Int) -> String {
        return amount == 1 ? self.humanReadable.singular : self.humanReadable.plural
    }
}
