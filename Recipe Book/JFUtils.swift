//
//  JFUtils.swift
//  Recipe Book
//
//  Created by Jonas Frey on 22.06.19.
//  Copyright © 2019 Jonas Frey. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

struct JFUtils {
    static func randomColor() -> Color {
        return Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1))
    }
}

struct JFLiterals {
    static let buttonBlue = UIColor(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    static let stepNumberColor = UIColor(red: 144.0/255.0, green: 203.0/255.0, blue: 180.0/255.0, alpha: 1.0)
    static let lightGrayBackgroundColor = UIColor(white: 0.95, alpha: 1.0)
    
    static let textFont = UIFont(name: "Avenir Next", size: 16)
    
    static let editingViewNibName = "EditingRecipeView"
    
    static let noUnit = "-"
    
}

struct Placeholder {
    
    static var sampleIngredients: [JFIngredient] = [
        JFIngredient(amount: 1, unit: .kilogram, name: "Mehl"),
        JFIngredient(amount: 100, unit: .gram, name: "Zucker"),
        JFIngredient(amount: 3, unit: .piece, name: "Eier"),
        JFIngredient(amount: 500, unit: .milliliter, name: "Milch"),
        JFIngredient(amount: 0, unit: JFUnitType.none, name: "Salz")
    ]
    
    static var sampleRecipes: [JFRecipe] = [
        JFRecipe(name: "Apfelkuchen", image: UIImage(named: "Apfelkuchen"), steps: ["Step 1", "Step 2", "Step 3\n(Last step)\nLine 3...ölak sjflöaks jdflökas jdflökasjdflökasjdflökaj sdflökjas lödfsa dfasdfa slkdfj haöl skejflöaksj efklöajse ölkf jalsök ejfasef\nLine 4\nLine 5"], ingredients: sampleIngredients, portionAmount: 1, portionType: .piece),
        JFRecipe(name: "Himbeerkuchen", image: UIImage(named: "Himbeerkuchen"), steps: ["Step 1", "Step 2", "Step 3\n(Last step)"], ingredients: sampleIngredients, portionAmount: 1, portionType: .piece),
        JFRecipe(name: "Cookies", image: UIImage(named: "Cookies"), steps: ["Step 1", "Step 2", "Step 3\n(Last step)"], ingredients: sampleIngredients, portionAmount: 1, portionType: .piece),
    ]
    
}

extension Array {
    
    /// Returns an array that contains the repeated contents of this array
    ///
    ///        [1, 2, 3].repeated(n: 2) == [1, 2, 3, 1, 2, 3]
    /// - Parameter n: The number of times, the content should be repeated
    func repeated(n: Int) -> [Array.Element] {
        guard n >= 0 else {
            return []
        }
        var arr = [Array.Element]()
        for _ in 0..<n {
            arr.append(contentsOf: self)
        }
        return arr
    }
}


