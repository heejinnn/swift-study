

import SwiftUI

struct EditTaskListView: View {
    @State var date = Date()
    @State private var selected = "Not started"
    var tasks: [String]
    var onEdit: (() -> Void)?
    
    var body: some View {
        List {
            ForEach(tasks, id: \.self) { task in
                VStack(alignment: .leading) {
                    Text(task)
                    HStack{
                        Text("Due date ")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        DatePicker(
                            "",
                            selection: $date,
                            displayedComponents: [.date]
                        )
                    }
                   
                    Picker("Choose course", selection: $selected) {
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
        .navigationBarItems(trailing:
                                HStack {         
                                    Button(action: {
                                        onEdit?()
                                    }) {
                                        Text("Done")
                                    }
                                }
        )
    }
}
