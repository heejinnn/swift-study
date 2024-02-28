
import SwiftUI

struct TaskListView: View {
    var tasks: [Task]
    var onDelete: ((IndexSet) -> Void)?
       
    var body: some View {
        List {
            ForEach(tasks.indices, id: \.self) { index in
                VStack(alignment: .leading) {
                    Text(tasks[index].name)
                        .font(.subheadline)
                    Text("Due date: \(tasks[index].dueDate)")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    Text("Status:  \(tasks[index].status)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .onDelete(perform: onDelete)
        }
    }
}
