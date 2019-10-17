//
//  JFRecipeDataSource.swift
//  Recipe Book
//
//  Created by Jonas Frey on 27.04.19.
//  Copyright © 2019 Jonas Frey. All rights reserved.
//

import Foundation
import UIKit

class JFRecipeDataSource: NSObject, ObservableObject {
    
    typealias FilterType = (JFRecipe) -> Bool
    let kRecipeListKey = "recipes"
    
    @Published var recipes = [JFRecipe]()
    @Published var filter: FilterType?
    @Published var isSorted: Bool = true
    
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
    
    static func createSearchTextFilter(_ searchText: String) -> FilterType {
        func filter(recipe: JFRecipe) -> Bool {
            return recipe.name.contains(searchText)
        }
        return filter(recipe:)
    }
    
    func loadRecipes() {
        if let data = UserDefaults.standard.value(forKey: kRecipeListKey) as? Data {
            let loadedRecipes = try? PropertyListDecoder().decode([JFRecipe].self, from: data)
            recipes = loadedRecipes ?? [JFRecipe]()
            print("Loaded \(recipes.count) recipes")
        } else {
            print("Data is nil")
            // TODO: Remove this debug statement
            recipes = Placeholder.sampleRecipes
        }
        // TODO: REMOVE THIS
        print("Overwriting with sample recipes")
        recipes = Placeholder.sampleRecipes.repeated(n: 10)
    }
    
    func saveRecipes() {
        do {
            let data = try PropertyListEncoder().encode(recipes)
            UserDefaults.standard.set(data, forKey: kRecipeListKey)
        } catch let e {
            print(e)
        }
    }
}
