//
//  JFRecipe.swift
//  Recipe Book
//
//  Created by Jonas Frey on 25.03.19.
//  Copyright © 2019 Jonas Frey. All rights reserved.
//

import Foundation
import SwiftUI

/// Represents a cooking recipe
/// A recipe must have the following properties:
/// - a name
/// - a recipe ID
/// - a portion amount
/// - a portion type
///
/// A recipe can have the following properties:
/// - an image
/// - a category
/// - tags
/// - description steps
/// - ingredients
class JFRecipe: Identifiable, Codable, ObservableObject {
    /// The name of the recipe
    @Published var name: String
    /// An image showing the result
    @Published var image: UIImage?
    let id: UUID
    @Published var category: String?
    @Published var tags: [String]
    
    /// The creation steps of the recipe
    @Published var steps: [String]
    /// The list of ingredients for the recipe
    @Published var ingredients: [JFIngredient]
    
    @Published var portionAmount: Int
    @Published var portionType: JFPortionType
    
    convenience init() {
        self.init(name: "", image: nil, steps: [], ingredients: [], portionAmount: 1, portionType: .serving)
    }
    
    init(name: String, image: UIImage?, steps: [String], ingredients: [JFIngredient], portionAmount: Int, portionType: JFPortionType, recipeID: UUID = UUID(), category: String? = nil, tags: [String] = []) {
        self.name = name
        self.image = image
        self.steps = steps
        self.ingredients = ingredients
        self.portionAmount = portionAmount
        self.portionType = portionType
        self.category = category
        self.tags = tags
        self.id = recipeID
    }
    
    // MARK: - Codable
    
    enum JFRecipeError: String, Error {
        case pngEncodingError = "Could not create PNG data from image"
    }
    
    var imagePath: URL {
        let documentsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDir
            // FIXME: Create and append an images directory
            //.appendingPathComponent("images")
            .appendingPathComponent(id.uuidString)
            .appendingPathExtension("png")
    }
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.steps = try container.decode([String].self, forKey: .steps)
        self.ingredients = try container.decode([JFIngredient].self, forKey: .ingredients)
        self.portionAmount = try container.decode(Int.self, forKey: .portionAmount)
        self.portionType = try container.decode(JFPortionType.self, forKey: .portionType)
        self.category = try container.decode(String?.self, forKey: .category)
        self.tags = try container.decode([String].self, forKey: .tags)
        
        if let data = try? Data(contentsOf: imagePath.absoluteURL) {
            self.image = UIImage(data: data)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        
        if let image = image {
            guard let data = image.pngData() else {
                throw JFRecipeError.pngEncodingError
            }
            try data.write(to: imagePath)
        }
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
        try container.encode(steps, forKey: .steps)
        try container.encode(ingredients, forKey: .ingredients)
        try container.encode(portionAmount, forKey: .portionAmount)
        try container.encode(portionType, forKey: .portionType)
        try container.encode(category, forKey: .category)
        try container.encode(tags, forKey: .tags)
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case steps
        case ingredients
        case portionAmount
        case portionType
        case id = "recipeID"
        case category
        case tags
    }
}

// MARK: - Equatable, Hashable
extension JFRecipe: Equatable, Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.name)
        hasher.combine(self.image)
        hasher.combine(self.id)
        hasher.combine(self.category)
        hasher.combine(self.tags)
        hasher.combine(self.steps)
        hasher.combine(self.ingredients)
        hasher.combine(self.portionAmount)
        hasher.combine(self.portionType)
    }
    
    static func == (lhs: JFRecipe, rhs: JFRecipe) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
