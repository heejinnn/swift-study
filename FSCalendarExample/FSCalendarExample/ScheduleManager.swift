

struct ScheduleManager {
    var selectedDate: String = ""
    var dataForDate: [String] = []
}

extension ScheduleManager {
    static let list: [ScheduleManager] = [
        ScheduleManager(selectedDate: "2024-01-01", dataForDate: ["일정 1", "일정 2"])
    ]
}
