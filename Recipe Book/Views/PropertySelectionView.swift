//
//  UnitSelectionView.swift
//  Recipe Book
//
//  Created by Jonas Frey on 20.10.19.
//  Copyright © 2019 Jonas Frey. All rights reserved.
//

import SwiftUI

struct PropertySelectionView<T: Hashable>: View {
    
    @Binding var property: T
    @State var values: [T]
    @State var title: String
    @State var label: (T) -> String
    
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .padding(.top, 8)
            List {
                ForEach(self.values, id: \.self) { value in
                    HStack {
                        Image(systemName: "checkmark")
                            .foregroundColor(Color.blue)
                            .hidden(self.property != value)
                        Button(self.label(value)) {
                            self.property = value
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
                // Recreate the List separators, since they have been deactivated in the RecipeDetailView
                .listRowBackground(VStack {
                    Spacer()
                    Divider()
                        .padding(.leading, 15)
                })
            }
        }
    }
}

struct UnitSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        PropertySelectionView(property: .constant(Placeholder.sampleIngredients.first!.unit), values: JFUnit.allCases, title: "Select Unit", label: { $0.humanReadable.plural })
            .previewLayout(.fixed(width: 300, height: 600))
    }
}
