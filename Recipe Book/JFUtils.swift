//
//  JFUtils.swift
//  Recipe Book
//
//  Created by Jonas Frey on 22.06.19.
//  Copyright © 2019 Jonas Frey. All rights reserved.
//

import Foundation
import UIKit

struct JFUtils {
    
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
        JFRecipe(name: "Apfelkuchen", image: UIImage(named: "apfelkuchen"), steps: ["Step 1", "Step 2", "Step 3\n(Last step)"], ingredients: sampleIngredients, portionAmount: 1, portionType: .piece),
        JFRecipe(name: "Kirschkuchen", image: nil, steps: ["Step 1", "Step 2", "Step 3\n(Last step)"], ingredients: sampleIngredients, portionAmount: 1, portionType: .piece),
        JFRecipe(name: "Cookies", image: nil, steps: ["Step 1", "Step 2", "Step 3\n(Last step)"], ingredients: sampleIngredients, portionAmount: 1, portionType: .piece),
    ]
    
}
