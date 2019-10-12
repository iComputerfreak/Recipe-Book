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
    @State private var steps: [String]
    
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.editMode) private var editMode
    
    private var stepsBackground: Color {
        let white = 0.9
        return colorScheme == .light ? Color(white: white) : Color(white: 1 - white)
    }
    
    init(recipe: JFRecipe) {
        self.recipe = recipe
        self._steps = State(initialValue: recipe.steps)
        // Globally disable table view separators
        UITableView.appearance().separatorColor = .clear
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HeaderView("Steps")
            Divider()
            List {
                // Steps
                ForEach(0..<self.recipe.steps.count) { i in
                    HStack(alignment: .top) {
                        // Step Number
                        Text("\(i + 1)")
                            .font(.title)
                            .bold()
                            .underline()
                            .foregroundColor(Color("Step Color"))
                            .frame(width: 60, height: 35, alignment: .trailing)
                        // Step description
                        if (self.editMode!.wrappedValue.isEditing) {
                            // FIXME: Change to editable
                            //self.stepEditingView(i)
                            self.stepView(i)
                                .background(self.stepsBackground)
                                .cornerRadius(5)
                        } else {
                            self.stepView(i)
                                .background(self.stepsBackground)
                                .cornerRadius(5)
                        }
                    }
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
                        self.steps.append("")
                    }
                }
            }
        }
    }
    
    func stepView(_ i: Int) -> some View {
        HStack {
            Text(self.recipe.steps[i])
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
