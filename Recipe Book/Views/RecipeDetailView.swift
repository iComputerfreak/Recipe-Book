//
//  RecipeDetailView.swift
//  Recipe Book
//
//  Created by Jonas Frey on 08.10.19.
//  Copyright © 2019 Jonas Frey. All rights reserved.
//

import SwiftUI

struct RecipeDetailView: View {
    
    // Reference to the object in the array
    @ObservedObject var recipe: JFRecipe
    @Environment(\.editMode) private var editMode
        
    func onAppear() {
        
    }
    
    var body: some View {
        ScrollView {
            HStack(alignment: VerticalAlignment.top, spacing: 30) {
                // Left View
                VStack {
                    HeaderView(self.recipe.name)
                        .environment(\.editMode, self.editMode)
                    Spacer()
                        .frame(height: 50)
                    StepsView(recipe: self.recipe)
                        .environment(\.editMode, self.editMode)
                }
                // Right View
                VStack {
                    SquareImageView(image: self.recipe.image!)
                        .padding([.leading, .trailing], 100)
                        .padding([.bottom], 20)
                    IngredientsView(recipe: self.recipe)
                        .environment(\.editMode, self.editMode)
                }
            }
            .padding([.top], 30)
        }
        
        .navigationBarTitle(/*"\(self.recipe.name)"*/ "", displayMode: .inline)
        .navigationBarItems(trailing: EditButton())
        .onAppear(perform: self.onAppear)
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(recipe: Placeholder.sampleRecipes.first!)
        //.previewLayout(.fixed(width: 1112, height: 834))
    }
}
