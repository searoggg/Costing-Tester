//
//  CollapsibleCheckboxList.swift
//  Costing Tester
//
//  Created by Chris Rogers on 10/29/24.
//


import SwiftUI

struct CollapsibleCheckboxList: View {
    @EnvironmentObject var dataModel: SharedDataModel
    let title: String
    let options: [String]
    @Binding var selections: [String]
    @State private var isExpanded: Bool = false
    
    
//    let allergenType: [String] = [
//        "Milk",
//        "Eggs",
//        "Fish",
//        "Shellfish",
//        "Tree nuts",
//        "Peanuts",
//        "Wheat",
//        "Soybeans",
//        "Sesame"
//    ]

    //Change git
    
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: { isExpanded.toggle() }) {
                HStack {
                    Text(title)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 5).stroke(Color.gray))

            if isExpanded {
                            List(options, id: \.self) { allergen in
                                MultipleSelectionRow(
                                    title: allergen,
                                    isSelected: selections.contains(allergen)
                                ) {
                                    if let index = selections.firstIndex(of: allergen) {
                                        selections.remove(at: index)
                                    } else {
                                        selections.append(allergen)
                                    }
                                }
                            }
                            .listStyle(.plain)
                
            }
        }
    }
}

struct MultipleSelectionRow: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}
