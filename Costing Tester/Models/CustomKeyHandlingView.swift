//
//  CustomKeyHandlingView.swift
//  Costing Tester
//
//  Created by Chris Rogers on 11/1/24.
//


import AppKit

class CustomKeyHandlingView: NSView {
    
    var onKeyDown: ((NSEvent) -> Void)?
    
    override func keyDown(with event: NSEvent) {
        onKeyDown?(event)
    }
    
    override func becomeFirstResponder() -> Bool {
        true
    }
    
    override var acceptsFirstResponder: Bool {
        true
    }
}
import SwiftUI

struct GlobalKeyHandlingView: NSViewRepresentable {
    var onKeyDown: (NSEvent) -> Void
    
    func makeNSView(context: Context) -> CustomKeyHandlingView {
        let view = CustomKeyHandlingView()
        view.onKeyDown = onKeyDown
        return view
    }
    
    func updateNSView(_ nsView: CustomKeyHandlingView, context: Context) {
        nsView.onKeyDown = onKeyDown
    }
}
