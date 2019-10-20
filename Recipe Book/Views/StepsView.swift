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
                // This way we can allow equal steps (e.g. when adding 2 steps, both are "") and still can get the index
                ForEach(Array(self.recipe.steps.enumerated()), id: \.0.self) { (data: (index: Int, step: String)) in
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
    
    // TODO: Maybe move those functions into separate View structs
    /// The description part of the step row
    func stepView(_ description: String) -> some View {
        HStack {
            Text(description)
                .padding(8)
                .frame(minHeight: 35)
            // Expand the background to the whole width
            Spacer()
        }
    }
    
    /// The description part of the step row while in editing mode
    func stepEditingView(_ i: Int) -> some View {
        // TODO: Replace TextView with TextField.lineLimit(), after it has been fixed, or TextView been implemented
        //        TextField("", text: self.$steps[i], onEditingChanged: { _ in }) {
        //            // Commit
        //            self.commitChanges()
        //        }
        //            .lineLimit(nil)
        TextView(text: self.$recipe.steps[i])
    }
}

struct StepsView_Previews: PreviewProvider {
    static var previews: some View {
        StepsView()
            .previewLayout(.fixed(width: 400, height: 600))
            .environmentObject(Placeholder.sampleRecipes.first!)
    }
}
