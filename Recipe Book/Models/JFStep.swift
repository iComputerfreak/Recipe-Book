//
//  JFStep.swift
//  Recipe Book
//
//  Created by Jonas Frey on 22.10.19.
//  Copyright © 2019 Jonas Frey. All rights reserved.
//

import Foundation

/// Represents a uniquely identifiable recipe description step
struct JFStep: Codable, Equatable, Hashable, Identifiable {
    
    let id: UUID = UUID()
    /// The description text of the step
    var description: String
    
    init() {
        self.init("")
    }
    
    init(_ description: String) {
        self.description = description
    }
    
}
