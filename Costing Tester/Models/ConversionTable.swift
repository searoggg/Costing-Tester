//
//  ConversionTable.swift
//  Costing Tester
//
//  Created by Chris Rogers on 10/31/24.
//


// ConversionTable.swift

import Foundation
import SwiftUI

struct ConversionTable {
    // Define unit categories
    static let weightUnits: Array<String> = ["milligrams", "grams", "kilograms", "ounces", "pounds"]
    static let volumeUnits: Array<String> = ["milliliters", "liters", "cups", "pints", "quarts", "gallons", "fluid ounces", "tablespoons", "teaspoons"]
    static let eachUnits: Array<String> = ["bags", "each", "pieces", "items"]
    
    // Base conversion factors for weight and volume units
    static let weightConversions: [String: Double] = [
        // Milligrams conversions
        "milligramsToGrams": 0.001,
        "milligramsToKilograms": 0.000001,
        "milligramsToOunces": 0.000035274,
        "milligramsToPounds": 0.00000220462,
        
        // Grams conversions
        "gramsToMilligrams": 1000,
        "gramsToKilograms": 0.001,
        "gramsToOunces": 0.035274,
        "gramsToPounds": 0.00220462,
        
        // Kilograms conversions
        "kilogramsToMilligrams": 1_000_000,
        "kilogramsToGrams": 1000,
        "kilogramsToOunces": 35.274,
        "kilogramsToPounds": 2.20462,
        
        // Ounces conversions
        "ouncesToMilligrams": 28_349.5,
        "ouncesToGrams": 28.3495,
        "ouncesToKilograms": 0.0283495,
        "ouncesToPounds": 0.0625,
        
        // Pounds conversions
        "poundsToMilligrams": 453_592,
        "poundsToGrams": 453.592,
        "poundsToKilograms": 0.453592,
        "poundsToOunces": 16
    ]
    
    
    static let volumeConversions: [String: Double] = [
        // Milliliters conversions
        "millilitersToLiters": 0.001,
        "millilitersToCups": 0.00422675,
        "millilitersToPints": 0.00211338,
        "millilitersToQuarts": 0.00105669,
        "millilitersToGallons": 0.000264172,
        "millilitersToFluidOunces": 0.033814,
        "millilitersToTablespoons": 0.067628,
        "millilitersToTeaspoons": 0.202884,
        
        // Liters conversions
        "litersToMilliliters": 1000,
        "litersToCups": 4.22675,
        "litersToPints": 2.11338,
        "litersToQuarts": 1.05669,
        "litersToGallons": 0.264172,
        "litersToFluidOunces": 33.814,
        "litersToTablespoons": 67.628,
        "litersToTeaspoons": 202.884,
        
        // Cups conversions
        "cupsToMilliliters": 236.588,
        "cupsToLiters": 0.236588,
        "cupsToPints": 0.5,
        "cupsToQuarts": 0.25,
        "cupsToGallons": 0.0625,
        "cupsToFluidOunces": 8,
        "cupsToTablespoons": 16,
        "cupsToTeaspoons": 48,
        
        // Pints conversions
        "pintsToMilliliters": 473.176,
        "pintsToLiters": 0.473176,
        "pintsToCups": 2,
        "pintsToQuarts": 0.5,
        "pintsToGallons": 0.125,
        "pintsToFluidOunces": 16,
        "pintsToTablespoons": 32,
        "pintsToTeaspoons": 96,
        
        // Quarts conversions
        "quartsToMilliliters": 946.353,
        "quartsToLiters": 0.946353,
        "quartsToCups": 4,
        "quartsToPints": 2,
        "quartsToGallons": 0.25,
        "quartsToFluidOunces": 32,
        "quartsToTablespoons": 64,
        "quartsToTeaspoons": 192,
        
        // Gallons conversions
        "gallonsToMilliliters": 3785.41,
        "gallonsToLiters": 3.78541,
        "gallonsToCups": 16,
        "gallonsToPints": 8,
        "gallonsToQuarts": 4,
        "gallonsToFluidOunces": 128,
        "gallonsToTablespoons": 256,
        "gallonsToTeaspoons": 768,
        
        // Fluid Ounces conversions
        "fluidOuncesToMilliliters": 29.5735,
        "fluidOuncesToLiters": 0.0295735,
        "fluidOuncesToCups": 0.125,
        "fluidOuncesToPints": 0.0625,
        "fluidOuncesToQuarts": 0.03125,
        "fluidOuncesToGallons": 0.0078125,
        "fluidOuncesToTablespoons": 2,
        "fluidOuncesToTeaspoons": 6,
        
        // Tablespoons conversions
        "tablespoonsToMilliliters": 14.7868,
        "tablespoonsToLiters": 0.0147868,
        "tablespoonsToCups": 0.0625,
        "tablespoonsToPints": 0.03125,
        "tablespoonsToQuarts": 0.015625,
        "tablespoonsToGallons": 0.00390625,
        "tablespoonsToFluidOunces": 0.5,
        "tablespoonsToTeaspoons": 3,
        
        // Teaspoons conversions
        "teaspoonsToMilliliters": 4.92892,
        "teaspoonsToLiters": 0.00492892,
        "teaspoonsToCups": 0.0208333,
        "teaspoonsToPints": 0.0104167,
        "teaspoonsToQuarts": 0.00520833,
        "teaspoonsToGallons": 0.00130208,
        "teaspoonsToFluidOunces": 0.166667,
        "teaspoonsToTablespoons": 0.333333
    ]
    
    let allUnits = Array(weightUnits)
    + Array(volumeUnits)
    + Array(eachUnits)
    
    
    let firstUnit = weightUnits.first!
    
    // Function to get a conversion factor between compatible units
    static func conversionFactor(from fromUnit: String, to toUnit: String) throws -> Double {
        // Check if units are known
        guard weightUnits.contains(fromUnit) || volumeUnits.contains(fromUnit) || eachUnits.contains(fromUnit) else {
            throw ConversionError.unknownUnit(unit: fromUnit)
        }
        guard weightUnits.contains(toUnit) || volumeUnits.contains(toUnit) || eachUnits.contains(toUnit) else {
            throw ConversionError.unknownUnit(unit: toUnit)
        }
        
        // Ensure units are in the same category
        if (weightUnits.contains(fromUnit) && weightUnits.contains(toUnit)) ||
            (volumeUnits.contains(fromUnit) && volumeUnits.contains(toUnit)) {
            let key = "\(fromUnit)To\(toUnit)"
            if let factor = weightConversions[key] ?? volumeConversions[key] {
                return factor
            } else {
                throw ConversionError.conversionNotFound(fromUnit: fromUnit, toUnit: toUnit)
            }
        } else {
            throw ConversionError.incompatibleUnits(fromUnit: fromUnit, toUnit: toUnit)
        }
    }
}
