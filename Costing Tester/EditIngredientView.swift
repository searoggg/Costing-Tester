//
//  EditIngredientView.swift
//  Costing Tester
//
//  Created by Chris Rogers on 10/29/24.
//



import SwiftUI

struct EditIngredientView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var dataModel: SharedDataModel
    @Binding var ingredient: Ingredient

    @State private var name: String
    @State private var unitsPurchased: String
    @State private var unitType: String
    @State private var purchaseCost: String
    @State private var weightConversionFactor: String? = nil
    @State private var usableWeightPercentage: String
    @State private var allergens: String
    @State private var notes: String

    let unitTypes: [String] = [
        "Pound",
        "Ounce",
        "Kilogram",
        "Gram",
        "Gallon",
        "Quart",
        "Pint",
        "Cup",
        "Fl Ounce",
        "Liter",
        "Each",
        "Bag",
        "Bunch",
        "Box"
    ]
    let allergenType: [String] = [
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


    init(ingredient: Binding<Ingredient>) {
        self._ingredient = ingredient
        self._name = State(initialValue: ingredient.wrappedValue.name)
        self._unitsPurchased = State(initialValue: String(ingredient.wrappedValue.unitsPurchased))
        self._unitType = State(initialValue: ingredient.wrappedValue.unitType)
        self._purchaseCost = State(initialValue: String(ingredient.wrappedValue.purchaseCost))
        self._weightConversionFactor = State(initialValue: ingredient.wrappedValue.weightConversionFactor != nil ? String(ingredient.wrappedValue.weightConversionFactor!) : nil)
        self._usableWeightPercentage = State(initialValue: String(ingredient.wrappedValue.usableWeightPercentage))
        self._allergens = State(initialValue: ingredient.wrappedValue.allergens.joined(separator: ", "))
        self._notes = State(initialValue: ingredient.wrappedValue.notes)
    }

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Ingredient Info")) {
                    TextField("Name", text: $name)
                    TextField("Units Purchased", text: $unitsPurchased)

                    Picker("Unit Type", selection: $unitType) {
                        ForEach(unitTypes, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                    TextField("Purchase Cost", text: $purchaseCost)

                }

                Section(header: Text("Conversion & Usability")) {
                    if unitType != "Pound" && unitType != "Ounce" && unitType != "Kilogram" && unitType != "Gram" {
                        TextField("Weight Conversion Factor", text: Binding(
                            get: { weightConversionFactor ?? "" },
                            set: { weightConversionFactor = $0.isEmpty ? nil : $0 }
                        ))

                    }
                    TextField("Usable Weight Percentage", text: $usableWeightPercentage)

                }

                Section(header: Text("Additional Info")) {
                    TextField("Allergens", text: $allergens)
                    TextField("Notes", text: $notes)
                }
            }
            .padding()
            .frame(width: 600, height: 600)
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    ingredient.name = name
                    ingredient.unitsPurchased = Double(unitsPurchased) ?? 0
                    ingredient.unitType = unitType
                    ingredient.purchaseCost = Double(purchaseCost) ?? 0
                    ingredient.weightConversionFactor = weightConversionFactor != nil ? Double(weightConversionFactor!) : nil
                    ingredient.usableWeightPercentage = Double(usableWeightPercentage) ?? 0
                    ingredient.allergens = allergens.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
                    ingredient.notes = notes
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}
