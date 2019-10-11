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
        
    func onAppear() {
        
    }
    
    var body: some View {
        ScrollView {
            HStack(alignment: VerticalAlignment.top, spacing: 30) {
                // Left View
                VStack {
                    HeaderView(self.recipe.name)
                    Spacer()
                        .frame(height: 50)
                    StepsView(steps: self.recipe.steps)
                    Spacer()
                }
                // Right View
                VStack {
                    SquareImageView(image: self.recipe.image!)
                        .padding([.leading, .trailing], 100)
                        .padding([.bottom], 20)
                    IngredientsView(recipe: self.recipe)
                    //Spacer()
                }
            }
            .padding([.top], 30)
        }
        
        .navigationBarTitle(/*"\(self.recipe.name)"*/ "", displayMode: .inline)
        .onAppear(perform: self.onAppear)
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(recipe: Placeholder.sampleRecipes.first!)
        //.previewLayout(.fixed(width: 1112, height: 834))
    }
}
