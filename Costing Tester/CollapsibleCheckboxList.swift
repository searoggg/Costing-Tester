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
    
    private let columns = [
          GridItem(.flexible()),
          GridItem(.flexible()),
          GridItem(.flexible())
      ] // Defines a 3-column grid layout

    //Change git
    
    var body: some View {
        
        
        VStack(alignment: .center) {
//            Button(action: { isExpanded.toggle() }) {
//                HStack {
//                    Text(title)
//                    Spacer()
//                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
//                }
//            }
//            .padding()
//            .background(RoundedRectangle(cornerRadius: 5).stroke(Color.purple))
            
//            if isExpanded {
            GeometryReader { geo in
                LazyVGrid(columns: columns, alignment: .leading, spacing: 10) {
                    ForEach(options, id: \.self) { allergen in
                        HStack {
                            Image(systemName: selections.contains(allergen) ? "checkmark.square" : "square")
                            Text(allergen)
                        }
                        .padding(.vertical, 5)
                        .onTapGesture {
                            toggleSelection(for: allergen)
                        } // Applies toggle action to both checkbox and text
                    }
                }
                .padding(.vertical, 5)
                .border(Color.purple)
                //                ScrollView {
                //                    VStack(alignment: .leading, spacing: 10) {
                //                        ForEach(options, id: \.self) { allergen in
                //                            MultipleSelectionRow(
                //                                title: allergen,
                //                                isSelected: selections.contains(allergen)
                //                            ) {
                //                                if let index = selections.firstIndex(of: allergen) {
                //                                    selections.remove(at: index)
                //                                } else {
                //                                    selections.append(allergen)
                //                                }
                //                            }
                //                        }
                //                    }
                //                    .padding(.vertical, 5)
                //                }
                //                .frame(maxHeight: 200) // Adjust this max height as needed
                
                //            }
            }
        }
    }
        private func toggleSelection(for allergen: String) {
            if let index = selections.firstIndex(of: allergen) {
                selections.remove(at: index)
            } else {
                selections.append(allergen)
            }
        }
    
}

//struct MultipleSelectionRow: View {
//    let title: String
//    let isSelected: Bool
//    let action: () -> Void
//
//    var body: some View {
//        Button(action: action) {
//            HStack {
//                Text(title)
//                Spacer()
//                if isSelected {
//                    Image(systemName: "checkmark")
//                }
//            }
//        }
//    }
//}
