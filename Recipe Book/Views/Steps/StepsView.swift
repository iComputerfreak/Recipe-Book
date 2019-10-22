//
//  StepsView.swift
//  Recipe Book
//
//  Created by Jonas Frey on 09.10.19.
//  Copyright © 2019 Jonas Frey. All rights reserved.
//

import SwiftUI

struct StepsView: View {
    
    @EnvironmentObject private var recipe: JFRecipe
    
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.editMode) private var editMode
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading) {
            HeaderView("Steps")
            Divider()
            List {
                // Steps
                // Pair the steps with their indices [(0, "Step 1"), (1, "Step 2"), ...] and use the index as key
                // This way we can allow equal steps (e.g. when adding 2 steps, both are "") and still get the index
                // FIXME: Cannot use index as key
                ForEach(Array(self.recipe.steps.enumerated()), id: \.0.self) { (data: (index: Int, step: String)) in
                    HStack(alignment: .top) {
                        if (self.editMode!.wrappedValue.isEditing) {
                            // FIXME: Change to editable
                            //self.stepEditingView(i)
                            StepView(index: data.index, description: self.$recipe.steps[data.index])
                        } else {
                            StepView(index: data.index, description: self.$recipe.steps[data.index])
                        }
                    }
                }
                .onDelete(perform: { indexSet in
                    self.recipe.steps.remove(atOffsets: indexSet)
                })
                    .onMove(perform: { (source, destination) in
                        self.recipe.steps.move(fromOffsets: source, toOffset: destination)
                    })
            }
            // Add Step
            if self.editMode!.wrappedValue.isEditing {
                Button(action: {
                    print("Adding step")
                    self.recipe.steps.append("")
                }, label: {
                    HStack {
                        Spacer()
                        Image(systemName: "plus.circle")
                        Text("Add Step")
                        Spacer()
                    }
                })
            }
        }
    }
}

struct StepsView_Previews: PreviewProvider {
    static var previews: some View {
        StepsView()
            .previewLayout(.fixed(width: 400, height: 600))
            .environmentObject(Placeholder.sampleRecipes.first!)
    }
}
