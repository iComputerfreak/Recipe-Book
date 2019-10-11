//
//  IngredientsView.swift
//  Recipe Book
//
//  Created by Jonas Frey on 09.10.19.
//  Copyright © 2019 Jonas Frey. All rights reserved.
//

import SwiftUI

struct IngredientsView: View {
    
    var recipe: JFRecipe
    @State private var stepperValue: Int = 1
    
    init(recipe: JFRecipe) {
        self.recipe = recipe
        self.stepperValue = recipe.portionAmount
    }
    
    var body: some View {
        VStack(alignment: .center) {
            HeaderView("Ingredients")
            Divider()
            Stepper("Für \(recipe.portionAmount) \(recipe.portionType.humanReadable(recipe.portionAmount))",
                value: $stepperValue, in: 0...100, onEditingChanged: { _ in self.recipe.portionAmount = self.stepperValue })
                .fixedSize(horizontal: true, vertical: false)
                .padding([.top, .bottom], 20)
            VStack(alignment: .leading) {
                ForEach(self.recipe.ingredients, id: \.self) { (ingredient: JFIngredient) in
                    HStack {
                        Text(self.amountString(ingredient.amount, unitType: ingredient.unit))
                            .frame(minWidth: 120, alignment: .trailing)
                        Text(ingredient.name)
                    }
                }
            }
        }
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
        IngredientsView(recipe: Placeholder.sampleRecipes.first!)
            .previewLayout(.fixed(width: 400, height: 600))
    }
}
