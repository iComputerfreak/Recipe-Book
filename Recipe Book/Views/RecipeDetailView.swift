//
//  RecipeDetailView.swift
//  Recipe Book
//
//  Created by Jonas Frey on 08.10.19.
//  Copyright © 2019 Jonas Frey. All rights reserved.
//

import SwiftUI
import UIKit

struct RecipeDetailView: View {
    
    // Page 133: Edge Insets
    // Combine Texts using + for different styles
    
    @EnvironmentObject private var recipe: JFRecipe
    @Environment(\.editMode) private var editMode
    
    func onAppear() {
        // Globally disable table view separators
        UITableView.appearance().separatorStyle = UITableViewCell.SeparatorStyle.none
        //UITableView.appearance().isScrollEnabled = false
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
                    StepsView()
                        .environment(\.editMode, self.editMode)
                }
                // Right View
                VStack {
                    ZStack {
                        SquareImageView(image: self.$recipe.image, defaultSystemImage: "doc.text")
                        // Image Editing Controls
                        if self.editMode!.wrappedValue.isEditing {
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    // Take new Photo
                                    Button(action: {
                                        //print("Take photo")
                                    }) {
                                        Image(systemName: "camera")
                                            .font(.system(size: 32))
                                    }
                                        
                                        // Space between Buttons
                                        .padding([.trailing], 10)
                                    
                                    // Select Photo
                                    Button(action: {
                                        print("Select photo")
                                    }) {
                                        Image(systemName: "photo")
                                            .font(.system(size: 32))
                                    }
                                    Spacer()
                                }
                                .padding(10)
                                .background(
                                    RoundedCorners(tl: 0, tr: 0, bl: SquareImageView.cornerRadius, br: SquareImageView.cornerRadius)
                                        .fill(Color(white: 0.8).opacity(0.8))
                                )
                            }
                        }
                    }
                    .padding([.leading, .trailing], 100)
                    .padding([.bottom], 20)
                    IngredientsView()
                        .environment(\.editMode, self.editMode)
                }
            }
            .padding(.top, 30)
            .padding(.bottom, 80)
        }
            
        .navigationBarTitle(/*"\(self.recipe.name)"*/ "", displayMode: .inline)
        .navigationBarItems(trailing: EditButton())
        .onAppear(perform: self.onAppear)
        // Hide the back button while editing
        .navigationBarBackButtonHidden(self.editMode!.wrappedValue.isEditing)
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView()
            .environmentObject(Placeholder.sampleRecipes.first!)
        //.previewLayout(.fixed(width: 1112, height: 834))
    }
}
