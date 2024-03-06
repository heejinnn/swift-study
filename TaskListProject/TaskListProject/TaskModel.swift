import SwiftUI

struct Task {
    var name: String
    var dueDate: Date
    var status: String
}

class TaskList: ObservableObject {
    @Published var tasks = [
        Task(name: "Task 1", dueDate: Date(), status: "Not started"),
        Task(name: "Task 2", dueDate: Date(), status: "In progress"),
        Task(name: "Task 3", dueDate: Date(), status: "Complete")
    ]
}
