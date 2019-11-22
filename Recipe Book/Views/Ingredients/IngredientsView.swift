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
    /// An offset to the recipe's `portionAmount` to use for the amount calculation of the ingredients
    @State private var portionAmountOffset: Int = 0
    @State private var showingPortionPicker: Bool = false
    
    @Environment(\.editMode) private var editMode
    
    private var overridingPortionAmount: Int {
        return self.recipe.portionAmount + self.portionAmountOffset
    }
    
    private var offsetRange: ClosedRange<Int> {
        let lower = 1 - self.recipe.portionAmount
        let upper = 100 - self.recipe.portionAmount
        return lower...upper
    }
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.center) {
            HeaderView("Ingredients")
            Divider()
            if self.editMode?.wrappedValue.isEditing ?? false {
                Stepper(value: self.$recipe.portionAmount, in: 1...100, onEditingChanged: { _ in
                    if !self.offsetRange.contains(self.portionAmountOffset) {
                        // Clamp offset to bounds
                        self.portionAmountOffset = self.portionAmountOffset.clamped(to: self.offsetRange)!
                    }
                }, label: {
                    HStack {
                        Text("For \(recipe.portionAmount)")
                        Button(recipe.portionType.humanReadable(recipe.portionAmount)) {
                            // Choose new portionType
                            self.showingPortionPicker = true
                        }
                        .popover(isPresented: self.$showingPortionPicker, arrowEdge: .trailing) {
                            PropertySelectionView(property: self.$recipe.portionType, values: JFPortion.allCases, title: "Select Portion Type") { portionType in
                                portionType.humanReadable.plural
                            }
                        }
                    }
                })
                    .fixedSize(horizontal: true, vertical: false)
                    .padding([.top, .bottom], 20)
            } else {
                Stepper("For \(overridingPortionAmount) \(recipe.portionType.humanReadable(overridingPortionAmount))", value: self.$portionAmountOffset, in: offsetRange)
                    .fixedSize(horizontal: true, vertical: false)
                    .padding([.top, .bottom], 20)
                    .onAppear {
                        // Execute this code when exiting edit mode or initially drawing the view
                        // Remove all empty ingredients
                        self.recipe.ingredients.removeAll { (ingredient) -> Bool in
                            return ingredient.name.isEmpty && ingredient.amount.isZero && ingredient.unit == .none
                        }
                }
            }
            List {
                // Map each ingredient to its index
                ForEach(Array(self.recipe.ingredients.enumerated()), id: \.1.id) { (index, _) in
                    IngredientRow(ingredient: self.$recipe.ingredients[index], portionAmount: self.$recipe.portionAmount, portionAmountOffset: self.$portionAmountOffset)
                        // Pass the edit mode down to the row
                        .environment(\.editMode, self.editMode)
                        .background(
                            (index % 2 == 0 ? Color("ListBackground") : Color.clear)
                                .cornerRadius(15)
                                .frame(height: self.cellBounds.height, alignment: .leading)
                    )
                }
                .onDelete(perform: { self.recipe.ingredients.remove(atOffsets: $0) })
                .onMove(perform: { self.recipe.ingredients.move(fromOffsets: $0, toOffset: $1) })
                    // Save the bounds of the list rows into ID 1
                    .listRowBackground(Color.clear.saveBounds(viewId: 1))
            }
                // Set the height of the List to perfectly fit its contents
                .frame(height: JFUtils.tableHeight(cellHeight: self.cellBounds.height, cellCount: self.recipe.ingredients.count))
                .padding(.horizontal, 50)
                // Retrieve the saved bounds into the variable
                .retrieveBounds(viewId: 1, self.$cellBounds)
            
            // Add Ingredient
            if self.editMode?.wrappedValue.isEditing ?? false {
                Button(action: {
                    print("Adding step")
                    self.recipe.ingredients.append(JFIngredient())
                }, label: {
                    HStack {
                        Spacer()
                        Image(systemName: "plus.circle")
                        Text("Add Ingredient")
                        Spacer()
                    }
                })
            }
        }
    }
}

struct IngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsView()
            .previewLayout(.fixed(width: 600, height: 600))
            .environmentObject(Placeholder.sampleRecipes.first!)
    }
}
