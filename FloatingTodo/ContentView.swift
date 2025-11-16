import SwiftUI

struct ContentView: View {
    @StateObject private var store = TodoStore()
    @State private var newText = ""
    @State private var editingItem: TodoItem? = nil
    @State private var editText = ""

    var body: some View {
        VStack(spacing: 12) {
            // 透明可拖拽区域（高度你可以调）
            WindowDragArea()
                .frame(height: 40)
                .background(Color.clear)
                .onAppear {
                    NSApp.windows.first?.isMovableByWindowBackground = true
                }
            // Title
            Text("Floating Todo")
                .font(.system(size: 18, weight: .bold))
                .padding(.top, 6)

            // Input box
            HStack {
                TextField("Add a new task...", text: $newText)
                    .textFieldStyle(.roundedBorder)

                Button("Add") {
                    guard !newText.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                    store.add(text: newText)
                    newText = ""
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.horizontal)

            // Todo List
            List {
                ForEach(store.items) { item in
                    Text(item.text)
                        .font(.system(size: 15))
                        .padding(6)
                        .onTapGesture {
                            editingItem = item
                            editText = item.text
                        }
                }
                .onDelete(perform: store.remove)
            }
            .listStyle(.plain)
            .frame(maxHeight: 250)
        }
        .frame(width: 300)
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(16)
        .shadow(radius: 12)
        .sheet(item: $editingItem) { item in
            editView(item)
        }
    }

    // 编辑窗口
    @ViewBuilder
    private func editView(_ item: TodoItem) -> some View {
        VStack(spacing: 20) {
            Text("Edit Todo")
                .font(.title3)
                .bold()

            TextField("Edit text", text: $editText)
                .textFieldStyle(.roundedBorder)
                .padding()

            HStack(spacing: 20) {
                Button("Cancel") {
                    editingItem = nil
                }

                Button("Save") {
                    store.update(id: item.id, newText: editText)
                    editingItem = nil
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
        .frame(width: 320)
    }
}
