//
//  IngredientRow.swift
//  Recipe Book
//
//  Created by Jonas Frey on 20.10.19.
//  Copyright © 2019 Jonas Frey. All rights reserved.
//

import SwiftUI

// FIXME:
// - The ActionSheet when tapping an Ingredient in EditMode does crash the app due to an unknown location
//   Using an Alert for now

struct IngredientRow: View {
    /// The width of the HStack containing the amount and the unit text / fields
    let amountUnitWidth: CGFloat = 160
    
    @Binding var ingredient: JFIngredient
    @Binding var portionAmount: Int
    
    @State private var showingUnitPicker: Bool = false
    @State private var editingAmount: String
    
    @Environment(\.editMode) private var editMode
    
    init(ingredient: Binding<JFIngredient>, portionAmount: Binding<Int>) {
        self._ingredient = ingredient
        self._portionAmount = portionAmount
        self._editingAmount = State(wrappedValue: JFUtils.amountFormatter.string(from: ingredient.wrappedValue.amount) ?? "0")
    }
    
    var body: some View {
        HStack {
            if self.editMode!.wrappedValue.isEditing {
                // Unit and amount
                HStack {
                    TextField("", text: $editingAmount, onEditingChanged: { stillEditing in
                        guard self.editingAmount.isEmpty else {
                            self.ingredient.amount = 0
                            return
                        }
                        if !stillEditing, let value = JFUtils.amountFormatter.number(from: self.editingAmount) {
                            self.ingredient.amount = value.doubleValue
                        }
                    })
                        .multilineTextAlignment(.trailing)
                        .labelsHidden()
                        .background(VStack {
                            Spacer()
                            Divider()
                                .background(Color.primary)
                                .padding(.leading, 8)
                        })
                        // Padding to the unit button
                        .padding(.trailing, 4)
                        .onAppear(perform: self.didEnterEditMode)
                    // Buttons do not work in a list in edit mode
                    Text(self.ingredient.unit.humanReadable(self.ingredient.amount))
                        // FIXME: Error when showing action sheet: Missing location, using an alert instead, for now
                        .popover(isPresented: self.$showingUnitPicker, arrowEdge: .trailing) {
                            PropertySelectionView(property: self.$ingredient.unit, values: JFUnitType.allCases, title: "Select Unit") { unit in
                                unit.humanReadable.plural
                            }
                    }
                    .onTapGesture {
                        // Open popup to ask for other ingredient
                        self.showingUnitPicker = true
                    }
                    .foregroundColor(Color.blue)
                }
                .frame(width: amountUnitWidth, alignment: .trailing)
                // Name
                TextField("", text: self.$ingredient.name)
                    .labelsHidden()
                    .background(VStack {
                        Spacer()
                        Divider()
                            .background(Color.primary)
                            .padding(.trailing, 8)
                    })
                    // Padding to the unit button
                    .padding(.leading, 4)
            } else {
                Text(JFUtils.amountString(ingredient.amount * Double(portionAmount), unitType: ingredient.unit))
                    .frame(width: amountUnitWidth, alignment: .trailing)
                Text(ingredient.name)
                Spacer()
            }
        }
    }
    
    private func didEnterEditMode() {
        // Reset the string value when going in editing mode
        self.editingAmount = JFUtils.amountFormatter.string(from: self.ingredient.amount) ?? ""
    }
}

struct IngredientRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 0) {
            IngredientRow(ingredient: .constant(Placeholder.sampleIngredients[0]), portionAmount: .constant(1))
            IngredientRow(ingredient: .constant(Placeholder.sampleIngredients[1]), portionAmount: .constant(1))
                .environment(\.editMode, .constant(.active))
        }
        .previewLayout(.fixed(width: 400, height: 56))
    }
}
