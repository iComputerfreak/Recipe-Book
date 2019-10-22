//
//  RecipeListView.swift
//  Recipe Book
//
//  Created by Jonas Frey on 22.06.19.
//  Copyright © 2019 Jonas Frey. All rights reserved.
//

import SwiftUI
import JFSwiftUI

struct RecipeListView : View {
    
    var recipes: [JFRecipe] = Placeholder.sampleRecipes
    
    static let spacing: CGFloat = 10
    static let itemSize: CGFloat = 300
    
    /// Returns the number of items that fit in one row, given the specified spacing and itemSize
    var itemsPerRow: Int {
        let screenWidth = UIScreen.main.bounds.width
        let itemsPerRow = Int(screenWidth / (RecipeListView.itemSize + RecipeListView.spacing))
        // There should be placed at least one item per row
        return itemsPerRow > 0 ? itemsPerRow : 1
    }
 
    var body: some View {
        VStack(spacing: Self.spacing) {
            ForEach(recipes.chunked(into: self.itemsPerRow), id: \.self) { (recipes: [JFRecipe]) in
                HStack(spacing: Self.spacing) {
                    ForEach(recipes) { (recipe: JFRecipe) in
                        RecipeThumbnail(recipe: recipe)
                    }
                    Spacer()
                }
            }
            Spacer()
        }
        .padding(Self.spacing)
    }
}

struct RecipeThumbnail: View {
    var recipe: JFRecipe
    
    var body: some View {
        VStack {
            if recipe.image != nil {
                Image(uiImage: recipe.image!)
                    .frame(width: RecipeListView.itemSize, height: RecipeListView.itemSize, alignment: .center)
                    .scaledToFit()
                    .aspectRatio(1.0, contentMode: .fit)
            } else {
                Image(systemName: "clock")
                .frame(width: RecipeListView.itemSize, height: RecipeListView.itemSize, alignment: .center)
                .scaledToFit()
                .aspectRatio(1.0, contentMode: .fit)
            }
            Text(recipe.name)
        }
        .padding(10)
        .border(Color.black, width: 3.0)
        .cornerRadius(10.0)
    }
}

#if DEBUG
struct RecipeListView_Previews : PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
#endif
