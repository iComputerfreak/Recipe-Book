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
    
    @EnvironmentObject private var recipe: JFRecipe
    
    @State private var cellBounds: CGRect = .zero
    @Environment(\.editMode) private var editMode
    
    var body: some View {
        VStack(alignment: .center) {
            HeaderView("Ingredients")
            Divider()
            Stepper("For \(recipe.portionAmount) \(recipe.portionType.humanReadable(recipe.portionAmount))", value: self.$recipe.portionAmount, in: 1...100)
                .fixedSize(horizontal: true, vertical: false)
                .padding([.top, .bottom], 20)
            List {
                ForEach(Array(0..<self.recipe.ingredients.count), id: \.self) { index in
                    IngredientRow(ingredient: self.$recipe.ingredients[index], portionAmount: self.$recipe.portionAmount)
                        // Pass the edit mode down to the row
                        .environment(\.editMode, self.editMode)
                        .background(
                            (index % 2 == 0 ? Color("ListBackground") : Color.clear)
                                .cornerRadius(15)
                                .frame(height: self.cellBounds.height, alignment: .leading)
                        )
                }
                .onDelete(perform: self.deleteIngredient(indexSet:))
                .onMove(perform: self.moveIngredient(from:to:))
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
    
    private func moveIngredient(from source: IndexSet, to destination: Int) {
        self.recipe.ingredients.move(fromOffsets: source, toOffset: destination)
    }
}

struct IngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsView()
            .previewLayout(.fixed(width: 600, height: 600))
            .environmentObject(Placeholder.sampleRecipes.first!)
    }
}
