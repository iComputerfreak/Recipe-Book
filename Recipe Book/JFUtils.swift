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
    
    static var amountFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    static func randomColor() -> Color {
        return Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1))
    }
    
    /// Calculates the height a UITableView needs to display it's content.
    /// Does not respect headers or footers
    /// - Parameter cellHeight: The height of the UITableViewCells
    /// - Parameter cellCount: The number of cells to display
    static func tableHeight(cellHeight: CGFloat, cellCount: Int) -> CGFloat {
        // A divider has a guessed height of 1/3
        // FIXME: Formula still not exact
        // Currently works for up to 30 ingredients
        return CGFloat(cellCount) * (cellHeight + (1/3) + 0.3)
    }
    
    static func amountString(_ amount: Double, unitType: JFUnit? = nil) -> String {
        // TODO: Check if units exceed maximum (e.g. 1000 ml = 1 l)
        var amountStr = ""
        if amount != 0 {
            amountStr = amountFormatter.string(from: NSNumber(floatLiteral: amount))!
        }
        if unitType != nil && unitType != JFUnit.none {
            // Only if the ingredients list shows "1", use the singular (e.g. 1.00001 would be displayed as "1" -> singular)
            // Empty amount (e.g. "Prise Salz" should also use the singular)
            amountStr += " " + unitType!.humanReadable(amount)
        }
        return amountStr
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
        JFIngredient(amount: 0, unit: JFUnit.none, name: "Salz")
    ]
    
    static var sampleSteps: [JFStep] = [
        JFStep("Lorem ipsum dolor sit amet"),
        JFStep("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua."),
        JFStep("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.\nAt vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum.\nStet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.\nNewline")
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
    ///     [1, 2, 3].repeated(n: 2) == [1, 2, 3, 1, 2, 3]
    ///     
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

extension NumberFormatter {
    func string(from doubleValue: Double) -> String? {
        return self.string(from: NSNumber(floatLiteral: doubleValue))
    }
}
