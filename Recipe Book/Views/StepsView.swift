//
//  StepsView.swift
//  Recipe Book
//
//  Created by Jonas Frey on 09.10.19.
//  Copyright © 2019 Jonas Frey. All rights reserved.
//

import SwiftUI

struct StepsView: View {
    
    var recipe: JFRecipe
    @State private var steps: [String] {
        didSet {
            // Save the edited steps to the original recipe
            self.commitChanges()
        }
    }
    
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.editMode) private var editMode
    
    init(recipe: JFRecipe) {
        self.recipe = recipe
        self._steps = State(initialValue: recipe.steps)
    }
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading) {
            HeaderView("Steps")
            Divider()
            List {
                // Steps
                // Pair the steps with their indices [(0, "Step 1"), (1, "Step 2"), ...] and use the index as key
                // This way we can allow equal steps (e.g. when adding 2 steps, both are "") and still can get the index
                ForEach(Array(self.steps.enumerated()), id: \.0.self) { (data: (index: Int, step: String)) in
                    HStack(alignment: .top) {
                        // Step Number
                        if !self.editMode!.wrappedValue.isEditing {
                            Text("\(data.index + 1)")
                                .font(.title)
                                .bold()
                                .underline()
                                .foregroundColor(Color("StepColor"))
                                .frame(width: 60, height: 35, alignment: .trailing)
                        }
                        // Step description
                        if (self.editMode!.wrappedValue.isEditing) {
                            // FIXME: Change to editable
                            //self.stepEditingView(i)
                            self.stepView(data.step)
                                .background(Color("ListBackground"))
                                .cornerRadius(5)
                        } else {
                            self.stepView(data.step)
                                .background(Color("ListBackground"))
                                .cornerRadius(5)
                        }
                    }
                }
                .onDelete(perform: self.deleteStep(indexSet:))
                .onMove(perform: self.moveStep(from:to:))
                
                // Add Step
                if self.editMode!.wrappedValue.isEditing {
                    // TODO: Change this back to button or enable the fade-out while tapped
                    HStack {
                        Spacer()
                        Image(systemName: "plus.circle")
                        Text("Add Step")
                        Spacer()
                    }
                    .foregroundColor(Color.blue)
                    .onTapGesture {
                        print("Adding step")
                        self.steps.append("")
                        print("Steps: \(self.steps.count)")
                    }
                }
            }
        }
    }
    
    func stepView(_ description: String) -> some View {
        HStack {
            Text(description)
                .padding(8)
                .frame(minHeight: 35)
            // Expand the background to the whole width
            Spacer()
        }
    }
    
    func stepEditingView(_ i: Int) -> some View {
        // TODO: Replace TextView with TextField.lineLimit(), after it has been fixed, or TextView been implemented
        //        TextField("", text: self.$steps[i], onEditingChanged: { _ in }) {
        //            // Commit
        //            self.commitChanges()
        //        }
        //            .lineLimit(nil)
        TextView(text: self.$steps[i])
    }
    
    func deleteStep(indexSet: IndexSet) {
        self.steps.remove(atOffsets: indexSet)
    }
    
    func moveStep(from source: IndexSet, to destination: Int) {
        self.steps.move(fromOffsets: source, toOffset: destination)
    }
    
    /// Saves the changed steps to the original recipe
    private func commitChanges() {
        self.recipe.steps = self.steps
    }
}

struct StepEditingRow: View {
    var i: Int
    
    var body: some View {
        Text("")
    }
}

struct StepsView_Previews: PreviewProvider {
    static var previews: some View {
        StepsView(recipe: Placeholder.sampleRecipes.first!)
            .previewLayout(.fixed(width: 400, height: 600))
    }
}
