

import SwiftUI

struct ContentView: View {
    @State private var tasks = ["Task 1", "Task 2", "Task 3"]
    @State private var isEditing = false
    @State private var isAdding = true

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(tasks, id: \.self) { task in
                        VStack(alignment: .leading) { 
                            Text(task)
                            Text("Due date: ")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text("Status:  ")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                        }
                    }
                    .onDelete(perform: deleteTask)
                }
                
            }
            .navigationTitle("Tasks")
            .navigationBarItems(trailing:
                                    HStack {
                if isAdding {
                    Button(action: {
                        tasks.append("New Task")
                    }) {
                        Image(systemName: "plus")
                    }
                }
                if isEditing {
                    Button(action: {
                        isEditing.toggle()
                        isAdding.toggle()
                    }) {
                        Text("Done")
                    }
                } else {
                    Button(action: {
                        isEditing.toggle()
                        isAdding.toggle()
                    }) {
                        Text("Edit")
                    }
                }
            }
            )
        }
    }
    
    private func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}


#Preview {
    ContentView()
}
