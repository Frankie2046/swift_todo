//
//  FloatingWindow.swift
//  FloatingTodo
//
//  Created by fynn on 2025/11/16.
//

import AppKit
import SwiftUI

class FloatingWindow {
    static let shared = FloatingWindow()
    
    private var window: NSWindow?
    
    func showWindow() {
        if window == nil {
            let content = ContentView()
            let hosting = NSHostingView(rootView: content)

            let w = NSWindow(
                contentRect: NSRect(x: 400, y: 400, width: 260, height: 320),
                styleMask: [.titled, .fullSizeContentView],
                backing: .buffered,
                defer: false
            )
            
            w.isReleasedWhenClosed = false
            w.titleVisibility = .hidden
            w.titlebarAppearsTransparent = true
            w.standardWindowButton(.closeButton)?.isHidden = true
            w.standardWindowButton(.miniaturizeButton)?.isHidden = true
            w.standardWindowButton(.zoomButton)?.isHidden = true

            w.level = .floating
            w.isOpaque = false
            w.backgroundColor = .clear
            w.contentView = hosting
            window = w
        }
        window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }
    
    func hideWindow() {
        window?.orderOut(nil)
    }
    
    func toggleWindow() {
        if window?.isVisible == true {
            hideWindow()
        } else {
            showWindow()
        }
    }
}
