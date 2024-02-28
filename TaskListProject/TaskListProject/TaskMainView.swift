

import SwiftUI

struct TaskMainView: View {
    @State private var tasks = [ "Task1", "Task2", "Task3"]
    @State private var isEditing = false
    @State private var isAdding = true

    var body: some View {
        NavigationView {
            VStack {
                if isEditing {
                    EditTaskListView(tasks: tasks, onEdit: {
                        isEditing.toggle()
                    })
                } else {
                    TaskListView(tasks: tasks, onDelete: deleteTask)
                        .navigationBarItems(trailing:
                                                HStack {
                                                    Button(action: {
                                                        tasks.append("New Task")
                                                    }) {
                                                        Image(systemName: "plus")
                                                    }
                                                    Button(action: {
                                                        isEditing.toggle()
                                                        isAdding.toggle()
                                                    }) {
                                                        Text("Edit")
                                                    }
                                                }
                        )
                }
            }
            .navigationTitle("Tasks")
        }
    }

    private func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}

#Preview {
    TaskMainView()
}
