import SwiftUI

@main
struct FloatingTodoApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        MenuBarExtra("Todo", systemImage: "checkmark.circle") {
            Button("显示/隐藏 Todo 窗口") {
                FloatingWindow.shared.toggleWindow()
            }
            Divider()
            Button("退出") {
                NSApp.terminate(nil)
            }
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        FloatingWindow.shared.showWindow()
    }
}
