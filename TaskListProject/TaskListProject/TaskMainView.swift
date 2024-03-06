

import SwiftUI

struct TaskMainView: View {
    @ObservedObject var taskList = TaskList()
    @State private var isEditing = false
    @State private var isAdding = true

    var body: some View {
        NavigationView {
            VStack {
                if isEditing {
                    EditTaskListView(tasks: $taskList.tasks)
                        .navigationBarItems(trailing:
                                                HStack {
                                                    Button(action: {
                                                        isEditing.toggle()
                                                    }) {
                                                        Text("Done")
                                                    }
                                                }
                        )
                    
                } else {
                    TaskListView(tasks: $taskList.tasks, onDelete: deleteTask)
                        .navigationBarItems(trailing:
                                                HStack {
                                                    Button(action: {
                                                        taskList.tasks.append(Task(name: "new Task", dueDate: Date(), status: "Not started"))
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
        taskList.tasks.remove(atOffsets: offsets)
    }
}

#Preview {
    TaskMainView()
}
