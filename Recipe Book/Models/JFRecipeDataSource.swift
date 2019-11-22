//
//  JFRecipeDataSource.swift
//  Recipe Book
//
//  Created by Jonas Frey on 27.04.19.
//  Copyright © 2019 Jonas Frey. All rights reserved.
//

import Foundation
import UIKit

/// Represents a data source for recipes
class JFRecipeDataSource: NSObject, ObservableObject {
    
    typealias FilterType = (JFRecipe) -> Bool
    
    /// The raw list of recipes
    @Published var recipes = [JFRecipe]()
    /// The current filter
    @Published var filter: FilterType?
    /// Whether the recipes should be returned sorted when accessing them through `filteredRecipes`
    @Published var isSorted: Bool = true
    
    /// Returns all recipes that match the `filter`.
    /// If `isSorted` is true, the array returned will be sorted lexicographically.
    var filteredRecipes: [JFRecipe] {
        var sortedRecipes = recipes
        
        if isSorted {
            sortedRecipes = sortedRecipes.sorted(by: { (r1, r2) -> Bool in
                return r1.name.lexicographicallyPrecedes(r2.name)
            })
        }
        
        guard filter != nil else {
            return sortedRecipes
        }
        return sortedRecipes.filter(filter!)
    }
    
    init(filter: FilterType? = nil) {
        super.init()
        self.filter = filter
        loadRecipes()
        
        NotificationCenter.default.addObserver(self, selector: #selector(willResignActive(_:)), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    @objc func willResignActive(_ notification: Notification) {
        saveRecipes()
    }
    
    /// Creates a filter that matches all recipe names against the given text.
    /// - Parameter searchText: The text to match the recipe names against
    static func createSearchTextFilter(_ searchText: String) -> FilterType {
        return { (recipe: JFRecipe) in
            return recipe.name.contains(searchText)
        }
    }
    
    /// Loads the saved recipes from disk
    func loadRecipes() {
        recipes = []
        if let data = UserDefaults.standard.value(forKey: JFLiterals.Keys.recipes) as? Data {
            if let loadedRecipes = try? PropertyListDecoder().decode([JFRecipe].self, from: data) {
                recipes = loadedRecipes
                print("Loaded \(recipes.count) recipes")
            }
        } else {
            print("Data is nil")
        }
    }
    
    /// Saves the recipes to disk
    func saveRecipes() {
        do {
            let data = try PropertyListEncoder().encode(recipes)
            UserDefaults.standard.set(data, forKey: JFLiterals.Keys.recipes)
        } catch let e {
            print(e)
        }
    }
}
