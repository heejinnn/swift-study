

import SwiftUI

struct EditTaskListView: View {
    @Binding var tasks: [Task]
    
    var body: some View {
        List {
            ForEach(tasks.indices, id: \.self) { index in
                VStack(alignment: .leading) {
                    TextField(tasks[index].name, text: $tasks[index].name)
                    HStack{
                        Text("Due date")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        DatePicker(
                            "",
                            selection: $tasks[index].dueDate,
                            displayedComponents: [.date]
                        )
                    }
                   
                    Picker("", selection: $tasks[index].status) {
                        Text("Not started")
                            .tag("Not started")
                        Text("In progress")
                            .tag("In progress")
                        Text("Complete")
                            .tag("Complete")
                    }
                    .pickerStyle(.segmented)
                }
            }
        }
    }
}
