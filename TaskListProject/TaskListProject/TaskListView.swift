
import SwiftUI

struct TaskListView: View {
    var tasks: [String]
    var onDelete: ((IndexSet) -> Void)?
       
    var body: some View {
        List {
            ForEach(tasks, id: \.self) { task in
                VStack(alignment: .leading) {
                    Text(task)
                        .font(.subheadline)
                    Text("Due date: ")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    Text("Status:  ")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .onDelete(perform: onDelete)
        }
    }
}
