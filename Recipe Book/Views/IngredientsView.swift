//
//  IngredientsView.swift
//  Recipe Book
//
//  Created by Jonas Frey on 09.10.19.
//  Copyright © 2019 Jonas Frey. All rights reserved.
//

import SwiftUI

/// Represents a view displaying the list of ingredients of a given recipe
struct IngredientsView: View {
    
    var recipe: JFRecipe
    @State private var stepperValue: Int
    @Environment(\.editMode) private var editMode
    
    init(recipe: JFRecipe) {
        self.recipe = recipe
        self._stepperValue = State(initialValue: recipe.portionAmount)
    }
    
    var body: some View {
        VStack(alignment: .center) {
            HeaderView("Ingredients")
            Divider()
            Stepper("For \(stepperValue) \(recipe.portionType.humanReadable(recipe.portionAmount))", value: $stepperValue, in: 1...100)
                .fixedSize(horizontal: true, vertical: false)
                .padding([.top, .bottom], 20)
            // FIXME: Using VStack instead of List, because I cannot disable the scrolling in a List and I don't want my ingredients table to be scrollable
            VStack(alignment: .leading, spacing: 4) {
                ForEach(0..<self.recipe.ingredients.count) { i in
                    IngredientsRow(i: i, ingredient: self.recipe.ingredients[i], portionAmount: self.stepperValue)
                }
            }
            .padding(.horizontal, 100)
        }
    }
}

struct IngredientsRow: View {
    var i: Int
    var ingredient: JFIngredient
    var portionAmount: Int
    
    var body: some View {
        HStack {
            Text(amountString(ingredient.amount * Double(portionAmount), unitType: ingredient.unit))
                .frame(minWidth: 120, alignment: .trailing)
            Text(ingredient.name)
            Spacer()
        }
        .padding(.vertical, 4)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(i % 2 == 0 ? Color(white: 0.9) : Color.clear)
                .padding(.horizontal, 4)
        )
    }
    
    func amountString(_ amount: Double, unitType: JFUnitType?) -> String {
        // TODO: Check if units exceed maximum (e.g. 1000 ml = 1 l)
        var amountStr = ""
        if amount != 0 {
            let formatter = NumberFormatter()
            formatter.maximumFractionDigits = 2
            amountStr = formatter.string(from: NSNumber(floatLiteral: amount))!
        }
        if unitType != nil && unitType != JFUnitType.none {
            // Only if the ingredients list shows "1", use the singular (e.g. 1.00001 would be displayed as "1" -> singular)
            // Empty amount (e.g. "Prise Salz" should also use the singular)
            amountStr += " " + unitType!.humanReadable((amountStr == "1" || amountStr.isEmpty) ? 1 : 0)
        }
        return amountStr
    }
}

struct IngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            IngredientsRow(i: 0, ingredient: Placeholder.sampleIngredients[0], portionAmount: 1)
                .previewLayout(.sizeThatFits)
            IngredientsRow(i: 1, ingredient: Placeholder.sampleIngredients[1], portionAmount: 1)
                .previewLayout(.sizeThatFits)
            IngredientsView(recipe: Placeholder.sampleRecipes.first!)
                .previewLayout(.fixed(width: 400, height: 600))
        }
    }
}
