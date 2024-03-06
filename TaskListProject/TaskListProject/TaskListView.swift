
import SwiftUI

struct TaskListView: View {
    @Binding var tasks: [Task]
    var onDelete: ((IndexSet) -> Void)?
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
       
    var body: some View {
        List {
            ForEach(tasks.indices, id: \.self) { index in
                VStack(alignment: .leading) {
                    Text(tasks[index].name)
                        .font(.system(size: 16, weight: .bold))
                    Text("Due date: \(tasks[index].dueDate, formatter: dateFormatter)")
                        .font(.system(size: 14))
                    Text("Status:  \(tasks[index].status)")
                        .font(.subheadline)
                }
            }
            .onDelete(perform: onDelete)
        }
    }
}
