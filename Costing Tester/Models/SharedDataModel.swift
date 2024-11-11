//
//  SharedDataModel.swift
//  Costing Tester
//
//  Created by Chris Rogers on 10/29/24.
//


//
//  SharedDataModel.swift
//  CostingBuddy
//
//  Created by Chris Rogers on 10/22/24.
//


import SwiftUI
import Combine


class SharedDataModel: ObservableObject {

    @Published var ingredients: [Ingredient] = []
    @Published var recipes: [Recipe] = []
    @Published var allergenType: [String] = [
        "Milk",
        "Eggs",
        "Fish",
        "Shellfish",
        "Tree nuts",
        "Peanuts",
        "Wheat",
        "Soybeans",
        "Sesame"
    ]
   
    // You might add other shared state or methods here as needed
}

