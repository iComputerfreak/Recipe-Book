//
//  IngredientsView.swift
//  Recipe Book
//
//  Created by Jonas Frey on 09.10.19.
//  Copyright © 2019 Jonas Frey. All rights reserved.
//

import SwiftUI
import UIKit

/// Represents a view displaying the list of ingredients of a given recipe
struct IngredientsView: View {
    
    var recipe: JFRecipe
    
    @State private var cellBounds: CGRect = .zero
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
            List {
                ForEach(Array(self.recipe.ingredients.enumerated()), id: \.0.self) { (data: (index: Int, ingredient: JFIngredient)) in
                    IngredientsRow(i: data.index, ingredient: data.ingredient, portionAmount: self.stepperValue)
                        .background(
                            (data.index % 2 == 0 ? Color("ListBackground") : Color.clear)
                                .cornerRadius(15)
                                .frame(width: self.cellBounds.width, height: self.cellBounds.height, alignment: .leading)
                        )
                }
                .onDelete(perform: self.deleteIngredient(indexSet:))
                    // Save the bounds of the list rows into ID 1
                    .listRowBackground(Color.clear.saveBounds(viewId: 1))
            }
                // Set the height of the List to perfectly fit its contents
                .frame(height: JFUtils.tableHeight(cellHeight: self.cellBounds.height, cellCount: self.recipe.ingredients.count))
                .padding(.horizontal, 50)
                // Retrieve the saved bounds into the variable
                .retrieveBounds(viewId: 1, self.$cellBounds)
        }
    }
    
    private func deleteIngredient(indexSet: IndexSet) {
        self.recipe.ingredients.remove(atOffsets: indexSet)
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
            VStack(spacing: 0) {
                IngredientsRow(i: 0, ingredient: Placeholder.sampleIngredients[0], portionAmount: 1)
                IngredientsRow(i: 1, ingredient: Placeholder.sampleIngredients[1], portionAmount: 1)
            }
            .previewLayout(.fixed(width: 400, height: 56))
            IngredientsView(recipe: Placeholder.sampleRecipes.first!)
                .previewLayout(.fixed(width: 600, height: 600))
        }
    }
}
