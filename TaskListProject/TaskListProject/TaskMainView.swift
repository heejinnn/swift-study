

import SwiftUI

struct TaskMainView: View {
    @State private var tasks = [
        Task(name: "Task 1", dueDate: Date(), status: "Not started"),
        Task(name: "Task 2", dueDate: Date(), status: "In progress"),
        Task(name: "Task 3", dueDate: Date(), status: "Complete")
    ]
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
                                                        tasks.append(Task(name: "new Task", dueDate: Date(), status: "Not started"))
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
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }

    private func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}

#Preview {
    TaskMainView()
}
