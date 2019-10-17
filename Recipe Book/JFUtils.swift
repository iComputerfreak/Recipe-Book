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
    
    static var sampleSteps: [String] = [
        "Lorem ipsum dolor sit amet",
        "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.",
        "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.\nAt vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum.\nStet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.\nNewline"
    ]
    
    static var sampleRecipes: [JFRecipe] = [
        JFRecipe(name: "Apfelkuchen", image: UIImage(named: "Apfelkuchen"), steps: sampleSteps, ingredients: sampleIngredients, portionAmount: 1, portionType: .piece),
        JFRecipe(name: "Himbeerkuchen", image: UIImage(named: "Himbeerkuchen"), steps: sampleSteps, ingredients: sampleIngredients.repeated(n: 10), portionAmount: 1, portionType: .piece),
        JFRecipe(name: "Cookies", image: UIImage(named: "Cookies"), steps: sampleSteps.repeated(n: 10), ingredients: sampleIngredients, portionAmount: 1, portionType: .piece),
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


