

import SwiftUI
struct TodoListRow: View {
    var title: String
    @State private var isChecked: Bool = false

    var body: some View {
        HStack {
            Toggle(isOn: $isChecked) {
                Text(title)
            }
        }
    }
}

