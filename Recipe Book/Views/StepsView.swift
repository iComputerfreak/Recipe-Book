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
            self.recipe.steps = self.steps
        }
    }
    
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.editMode) private var editMode
    
    init(recipe: JFRecipe) {
        self.recipe = recipe
        self._steps = State(initialValue: recipe.steps)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HeaderView("Steps")
            Divider()
            List {
                // Steps
                ForEach(0..<self.steps.count) { i in
                    HStack(alignment: .top) {
                        // Step Number
                        Text("\(i + 1)")
                            .font(.title)
                            .bold()
                            .underline()
                            .foregroundColor(Color("StepColor"))
                            .frame(width: 60, height: 35, alignment: .trailing)
                        // Step description
                        if (self.editMode!.wrappedValue.isEditing) {
                            // FIXME: Change to editable
                            //self.stepEditingView(i)
                            self.stepView(self.steps[i])
                                .background(Color("ListBackground"))
                                .cornerRadius(5)
                        } else {
                            self.stepView(self.steps[i])
                                .background(Color("ListBackground"))
                                .cornerRadius(5)
                        }
                    }
                    Text("Step Count: \(self.steps.count)")
                }
                
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
                        self.steps.append("New Step")
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
        //            self.recipe.steps = self.steps
        //        }
        //            .lineLimit(nil)
        TextView(text: self.$steps[i])
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
