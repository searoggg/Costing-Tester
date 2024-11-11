//
//  IngredientDetailWindow.swift
//  Costing Tester
//
//  Created by Chris Rogers on 11/4/24.
//


import SwiftUI
import AppKit

struct IngredientDetailWindow: NSViewRepresentable {
    @Binding var ingredient: Ingredient
    @EnvironmentObject var dataModel: SharedDataModel
    @EnvironmentObject var formatters: Formatters

    func makeNSView(context: Context) -> NSView {
        let nsView = NSHostingView(rootView: IngredientDetailView(ingredient: $ingredient)
            .environmentObject(dataModel)
            .environmentObject(formatters))
        
        // Create a new NSWindow
        let window = NSWindow(contentViewController: NSHostingController(rootView: IngredientDetailView(ingredient: $ingredient)
            .environmentObject(dataModel)
            .environmentObject(formatters)))
        
        // Configure window settings
        window.title = "Ingredient Detail"
        window.styleMask = [.titled, .closable, .resizable]
        window.isReleasedWhenClosed = false
        window.center()
        
        // Automatically resize window to fit content
        window.setContentSize(window.contentView!.fittingSize)
        window.delegate = context.coordinator

        // Show the window
        window.makeKeyAndOrderFront(nil)
        
        return nsView
    }

    func updateNSView(_ nsView: NSView, context: Context) {
        // Update content if necessary
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    class Coordinator: NSObject, NSWindowDelegate {
        func windowWillClose(_ notification: Notification) {
            // Handle window close if needed
        }
    }
}
