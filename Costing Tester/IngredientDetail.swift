//
//  IngredientDetail.swift
//  Costing Tester
//
//  Created by Chris Rogers on 10/29/24.
//
import Foundation
import SwiftUI


struct IngredientDetailView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.isEnabled) var isEnabled
    @EnvironmentObject var dataModel: SharedDataModel
    @EnvironmentObject var formatters: Formatters
    
    
    @Binding var ingredient: Ingredient
    @State private var isEditing = false
    @State private var isWeightType = false
    @State private var selectedAllergens: [String] = []
    @State private var isAdditionalInfoOpen = false
    
    
    // Intermediate storage for numeric fields
    @State private var unitsPurchasedText: String = ""
    @State private var purchaseCostText: String = ""
    @State private var displayWeightPercentageText: String = "100"
    @State private var convWeightValueText: String = ""
    
    // Validation states
    @State private var isUnitsPurchasedValid = true
    @State private var isPurchaseCostValid = true
    @State private var isDisplayWeightPercentageValid = true
    @State private var isConvWeightValueValid = true
    
    
    let allUnits = Array(ConversionTable.weightUnits)
    + Array(ConversionTable.volumeUnits)
    + Array(ConversionTable.eachUnits)
    
    let nonWeightUnits = Array(ConversionTable.volumeUnits)
    + Array(ConversionTable.eachUnits)
    
    let weightUnits = Array(ConversionTable.weightUnits)
    
    
    
    
    
    
    
    var body: some View {
        VStack {
            Text("Ingredient Information")
                .font(.title2)
                .bold()
                .frame(maxWidth: .infinity, alignment: .center)
            
                .padding(.top, 50)
                .padding(.bottom, 5)
            
            
            
            
            ScrollView {
                
                
                
                if isEditing {
                    
                    GeometryReader { geometry in
                        
                        
                        VStack {
                            HStack {
                                Text("Name:")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding(.trailing, 10)
                                TextField("Ingredient Name", text: $ingredient.name)
                            }
                            .frame(minWidth: 1 * geometry.size.width)
                            //                        .border(Color.yellow)
                            .padding(.bottom, 1)
                            
                            
                            HStack {
                                Text("Units Purchased:")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding(.trailing, 10)
                                HStack{
                                    TextField("# of Units Purchased", text: $unitsPurchasedText)
                                        .border(isUnitsPurchasedValid ? Color.clear : Color.red)
                                        .frame(maxWidth: 70, alignment: .leading)
                                    
                                    
                                    Picker("Unit Type:", selection: $ingredient.unitType) {
                                        ForEach(allUnits, id: \.self) { unit in
                                            Text(unit)
                                        }
                                    }.frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading, 10)
                                }
                                .pickerStyle(MenuPickerStyle())
                                .onChange(of: ingredient.unitType) { // Use new `onChange` format
                                    isWeightType = weightUnits.contains(ingredient.unitType) // Update based on unit type
                                }
                                .focusable(true)
                                .padding(.trailing, 20)
                                
                            }
                            .frame(minWidth: 1 * geometry.size.width)
                            //                        .border(Color.yellow)
                            .padding(.bottom, 1)
                            
                            HStack {
                                Text("Purchase Cost:")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding(.trailing, 10)
                                HStack{
                                    Text("$")
                                    TextField("Enter purchase cost.", text: $purchaseCostText)
                                        .border(isPurchaseCostValid ? Color.clear : Color.red) // Red border if invalid
                                        .padding(.leading, -5)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.trailing, 135)
                            }
                            .frame(minWidth: 1 * geometry.size.width)
                            //                        .border(Color.yellow)
                            .padding(.bottom, 1)
                            
                            HStack {
                                Text("Per Unit Cost:")
                                    .frame(maxWidth: .infinity, alignment:.trailing)
                                    .padding(.trailing, 10)
                                Text("$\(ingredient.perUnitCost, specifier: "%.2f")")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .frame(minWidth: 1 * geometry.size.width)
                            //                        .border(Color.yellow)
                            .padding(.bottom, 1)
                            
                            HStack {
                                
                                Text("Usable Weight Percentage:")
                                    .frame(maxWidth: .infinity, alignment:.trailing)
                                    .padding(.trailing, 10)
                                TextField("Usable Weight Percentage", text: $displayWeightPercentageText)
                                    .border(isDisplayWeightPercentageValid ? Color.clear : Color.red) // Red border if invalid
                                    .frame(maxWidth: .infinity, alignment:.leading)
                                    .padding(.trailing, 215)
                                
                                
                            }
                            .frame(minWidth: 1 * geometry.size.width)
                            //                        .border(Color.yellow)
                            .padding(.bottom, 1)
                            
                            HStack {
                                Text("Adjusted Cost Per Unit:")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding(.trailing, 10)
                                Text("$\(ingredient.adjustedCostPerUnit, specifier: "%.2f")")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                            }
                            .frame(minWidth: 1 * geometry.size.width)
                            //                        .border(Color.yellow)
                            .padding(.bottom, 1)
                            
                            // Conditionally show weight conversion fields only if not a weight type
                            if !isWeightType {
                                HStack {
                                    Text("Weight Conversion:")
                                        .font(.headline)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .padding(5)
                                }
                                .frame(minWidth: 1 * geometry.size.width)
                                //                        .border(Color.yellow)
                                .padding(.bottom, 1)
                                HStack {
                                    
                                    HStack {
                                        Text("1")
                                        Picker("Unit Type", selection: $ingredient.convUnit) {
                                            ForEach(nonWeightUnits, id: \.self) { nwunit in
                                                Text(nwunit)
                                            }
                                        }
                                    }.frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.trailing, 10)
                                        .padding(.leading, 150)
                                    
                                    HStack {
                                        Text("=")
                                        TextField("", text: $convWeightValueText)
                                            .border(isConvWeightValueValid ? Color.clear : Color.red) // Red border if invalid
                                            .frame(maxWidth: 60)
                                        Text("in")
                                        
                                        Picker("", selection: $ingredient.convWeightUnit) {
                                            ForEach(weightUnits, id: \.self) { nwunit in
                                                Text(nwunit)
                                            }
                                            
                                        }.padding(.trailing, 60)
                                    }
                                }
                                .frame(minWidth: 1 * geometry.size.width, maxWidth: .infinity, alignment: .leading)
                                
                                
                                
                                
                            }
                            
                            Text("Additional Information")
                                .font(.title2)
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.vertical, 10)
                            
                            HStack {
                                HStack{
                                    Text("Allergens:")
                                        .font(.headline)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .padding(.trailing, 10)
                                }
                                HStack{
                                     // create a list of allergens including checkboxes to the left of them.
                                    CollapsibleCheckboxList(
                                        title: "Allergens",
                                        options: dataModel.allergenType,
                                        selections: $selectedAllergens
                                    )
                                    .environmentObject(dataModel)
                                        
                                }
                                    
                            }
                            .border(Color.red)
                    
//                            .padding(.bottom, 1)
                            HStack {
                                Text("Notes:")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding(.trailing, 10)
                                Text(ingredient.notes)
                                    .frame(maxWidth:.infinity, alignment:.leading)
                                
                            }
                            
                        }.frame(minWidth: 1 * geometry.size.width)
                    }
                    
                    
                } else {
                    GeometryReader { geometry in
                        
                        VStack {
                            HStack {
                                Text("Name:")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding(.trailing, 10)
                                //                                .border(Color.red)
                                
                                Text("\(ingredient.name)")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                //                                .border(Color.cyan)
                            }
                            .frame(minWidth: 1 * geometry.size.width)
                            //                        .border(Color.yellow)
                            .padding(.bottom, 1)
                            HStack {
                                Text("Units Purchased:")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding(.trailing, 10)
                                //                                .border(Color.red)
                                Text("\(ingredient.unitsPurchased, specifier: "%.2f") \(ingredient.unitType)")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .frame(minWidth: 1 * geometry.size.width)
                            //                        .border(Color.yellow)
                            .padding(.bottom, 1)
                            HStack {
                                Text("Purchase Cost:")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding(.trailing, 10)
                                Text("$\(ingredient.purchaseCost, specifier: "%.2f")")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            //                        .border(Color.red)
                            .padding(.bottom, 1)
                            HStack {
                                Text("Per Unit Cost:")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding(.trailing, 10)
                                Text("$\(ingredient.perUnitCost, specifier: "%.2f") per \(ingredient.unitType)")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            //                        .border(Color.red)
                            .padding(.bottom, 1)
                            HStack {
                                Text("Usable Weight Percentage:")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding(.trailing, 10)
                                Text("\(ingredient.displayWeightPercentage, specifier: "%.2f")%")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            //                        .border(Color.red)
                            .padding(.bottom, 1)
                            
                            if ingredient.usableWeightPercentage == 1 {
                                HStack {
                                    Text("Adjusted Cost Per Unit:")
                                        .font(.headline)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .padding(.trailing, 10)
                                    Text("$\(ingredient.adjustedCostPerUnit, specifier: "%.2f") per \(ingredient.weightConversionFactor ?? 1, specifier: "%.2f") Pound")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            }
                            if !isWeightType {
                                HStack {
                                    Text("Weight Conversion:")
                                        .font(.headline)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .padding(.trailing, 10)
                                    HStack {
                                        Text("1")
                                        Text("\(String(describing: ingredient.convUnit))")
                                        Text("=")
                                        Text("\(String(describing: ingredient.convWeightValue))")
                                        Text("\(String(describing: ingredient.convWeightUnit))")
                                        
                                    }
                                }
                                .padding(.bottom, 10)
                            }
                            //                        .border(Color.red)
                            
                            
                            Text("Additional Information")
                                .font(.title2)
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.vertical, 10)
                            
                            HStack {
                                Text("Allergens:")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding(.trailing, 10)
                                Text(ingredient.allergens.joined(separator: ", "))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            //                        .border(Color.red)
                            .padding(.bottom, 1)
                            HStack {
                                Text("Notes:")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding(.trailing, 10)
                                Text(ingredient.notes)
                                    .frame(maxWidth:.infinity, alignment:.leading)
                                
                            }
                            
                            
                        }
                        .frame(minWidth: 1 * geometry.size.width)
                        
                        
                    }
                    
                }
                //            }
            }
            .padding(.bottom, 10)
            .toolbar {
                Button(action: {
                    if isEditing {
                        if validateInputs() {
                            ingredient.unitsPurchased = Double(unitsPurchasedText) ?? 0
                            ingredient.purchaseCost = Double(purchaseCostText) ?? 0
                            ingredient.displayWeightPercentage = Double(displayWeightPercentageText) ?? 0
                            ingredient.convWeightValue = Double(convWeightValueText) ?? 0
                            isEditing = false
                        }
                    } else {
                        unitsPurchasedText = "\(ingredient.unitsPurchased)"
                        purchaseCostText = "\(ingredient.purchaseCost)"
                        displayWeightPercentageText = "\(ingredient.displayWeightPercentage)"
                        convWeightValueText = "\(ingredient.convWeightValue ?? 0.0)"
                        isEditing = true
                    }
                }) {
                    Text(isEditing ? "Done" : "Edit")
                        .foregroundColor(.white)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.blue)
                            
                        )
                }
                .buttonStyle(PlainButtonStyle())
                .focusable(true)// Prevents default toolbar style from overriding the color
                .padding(0)
                
                Button(action: {
                    isEditing = false
                    dismiss()
                }) {
                    Text(isEditing ? "Cancel" : "Done")
                        .foregroundColor(.white)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.red)
                            
                        )
                }
                .buttonStyle(PlainButtonStyle())
                .focusable(true)// Prevents default toolbar style from overriding the color
                .padding(5)
                
            }
            
            
            
            
            .frame(maxWidth:.infinity, alignment: .trailing)
            
            
            
            .padding(10)
        }
    }

    
    
    // Validation function
    private func validateInputs() -> Bool {
        isUnitsPurchasedValid = Double(unitsPurchasedText) != nil
        isPurchaseCostValid = Double(purchaseCostText) != nil
        isDisplayWeightPercentageValid = Double(displayWeightPercentageText) != nil
        isConvWeightValueValid = Double(convWeightValueText) != nil
        
        // Return true if all fields are valid
        return isUnitsPurchasedValid && isPurchaseCostValid && isDisplayWeightPercentageValid && isConvWeightValueValid
    }
}

#Preview {
    IngredientDetailView(
        ingredient: .constant(
            Ingredient(
                name: "Sample Ingredient",
                unitsPurchased: 10.0,
                unitType: "quarts",
                purchaseCost: 20.0,
                convUnit: "quarts",
                convWeightValue: 1000.0,
                convWeightUnit: "pounds",
                weightConversionFactor: 2.20462,
                displayWeightPercentage: 100.0,
                usableWeightPercentage: 90.0,
                allergens: ["Nuts", "Soy"],
                notes: "Sample note for ingredient details."
            )
        )
    )
    .environmentObject(SharedDataModel())
    .environmentObject(Formatters())
    
}

