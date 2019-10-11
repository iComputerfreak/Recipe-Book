//
//  GridCell.swift
//  Recipe Book
//
//  Created by Jonas Frey on 08.10.19.
//  Copyright © 2019 Jonas Frey. All rights reserved.
//

import SwiftUI

struct GridCell: View {
    
    var recipe: JFRecipe
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                Image(uiImage: self.recipe.image!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
            .clipped()
            .cornerRadius(15.0)
            .shadow(radius: 5)
            Text(self.recipe.name)
        }
        .aspectRatio(1.0, contentMode: .fit)
    }
}

struct GridCell_Previews: PreviewProvider {
    
    static var previews: some View {
        HStack {
            ForEach(Placeholder.sampleRecipes) { recipe in
                GridCell(recipe: recipe)
            }
        }
    }
}
