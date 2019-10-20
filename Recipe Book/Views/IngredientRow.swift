//
//  IngredientRow.swift
//  Recipe Book
//
//  Created by Jonas Frey on 20.10.19.
//  Copyright © 2019 Jonas Frey. All rights reserved.
//

import SwiftUI

struct IngredientRow: View {
    @Binding var ingredient: JFIngredient
    @Binding var portionAmount: Int
    
    @Environment(\.editMode) private var editMode
    
    var body: some View {
        HStack {
            if self.editMode!.wrappedValue.isEditing {
                TextField("", value: self.$ingredient.amount, formatter: NumberFormatter())
                    .labelsHidden()
                Button(self.ingredient.unit.humanReadable(self.ingredient.amount)) {
                    // Open popup to ask for other ingredient
                    print("")
                }
                TextField("", text: self.$ingredient.name)
                    .labelsHidden()
            } else {
                Text(amountString(ingredient.amount * Double(portionAmount), unitType: ingredient.unit))
                    .frame(minWidth: 120, alignment: .trailing)
                Text(ingredient.name)
                Spacer()
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
            amountStr += " " + unitType!.humanReadable(amount)
        }
        return amountStr
    }
}

struct IngredientRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 0) {
            IngredientRow(ingredient: .constant(Placeholder.sampleIngredients[0]), portionAmount: .constant(1))
            IngredientRow(ingredient: .constant(Placeholder.sampleIngredients[1]), portionAmount: .constant(1))
        }
        .previewLayout(.fixed(width: 400, height: 56))
    }
}
