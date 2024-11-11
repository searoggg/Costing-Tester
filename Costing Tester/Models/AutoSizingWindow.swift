//
//  AutoSizingWindowController.swift
//  Costing Tester
//
//  Created by Chris Rogers on 11/2/24.
//


import AppKit
import SwiftUI

class WindowManager: ObservableObject {
    func openWindow<Content: View>(with rootView: Content) {
        // Wrap the SwiftUI view in an NSHostingController
        let hostingController = NSHostingController(rootView: rootView)
        
        // Create a new NSWindow and embed the hosting controller
        let window = NSWindow(contentViewController: hostingController)
        
        // Configure the window style and appearance
        window.styleMask = [.titled, .closable, .resizable]
        window.isMovableByWindowBackground = true
        window.center()
        
        // Set the window size to fit the content initially
        hostingController.view.setFrameSize(hostingController.view.fittingSize)
        
        // Create an NSWindowController to manage the window lifecycle
        let windowController = NSWindowController(window: window)
        windowController.showWindow(nil)
        
        // Observe changes in the content view size for dynamic resizing
        NotificationCenter.default.addObserver(
            forName: NSView.frameDidChangeNotification,
            object: hostingController.view,
            queue: .main
        ) { _ in
            window.setContentSize(hostingController.view.fittingSize)
        }
    }
}




