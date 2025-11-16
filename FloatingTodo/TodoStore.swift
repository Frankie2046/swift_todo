import Foundation
import Combine     // 加这一行最关键！
import SwiftUI


class TodoStore: ObservableObject {
    @Published var items: [TodoItem] = []

    func add(text: String) {
        let new = TodoItem(text: text)
        items.append(new)
    }

    func remove(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }

    func update(id: UUID, newText: String) {
        if let index = items.firstIndex(where: { $0.id == id }) {
            items[index].text = newText
        }
    }
}

struct TodoItem: Identifiable {
    let id = UUID()
    var text: String
}

