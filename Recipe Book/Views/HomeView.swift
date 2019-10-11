//
//  HomeView.swift
//  Recipe Book
//
//  Created by Jonas Frey on 05.10.19.
//  Copyright © 2019 Jonas Frey. All rights reserved.
//

import SwiftUI
import JFSwiftUI
import QGrid

struct HomeView: View {
    
    @ObservedObject var dataSource = JFRecipeDataSource()
    
    private func onAppear() {
    }
    
    private func onDisappear() {
        dataSource.saveRecipes()
    }
    
    var body: some View {
        NavigationView {
            QGrid(self.dataSource.filteredRecipes, columns: 5, vSpacing: 10) { recipe in
                NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                    GridCell(recipe: recipe)
                }
                .buttonStyle(PlainButtonStyle())
            }
                
            .navigationBarTitle("Recipes", displayMode: .inline)
            .navigationBarItems(trailing: Button("Update") {
                self.dataSource.recipes.removeLast()
            })
        }
        .onAppear(perform: self.onAppear)
        .onDisappear(perform: self.onDisappear)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        return HomeView()
    }
}
