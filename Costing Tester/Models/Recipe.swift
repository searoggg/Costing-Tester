//
//  RecipeModel.swift
//  Costing Tester
//
//  Created by Chris Rogers on 10/29/24.
//

import Foundation
import SwiftData

struct Recipe: Identifiable, Hashable {
    
    var id = UUID()
    var name: String
    let ingredients: [Ingredient]
    var totalCost: Double
    var totalWeight: Double
    var weightUnit: String
    var recipeAllergens: [String]
    var notes: String
    
    
    
}

