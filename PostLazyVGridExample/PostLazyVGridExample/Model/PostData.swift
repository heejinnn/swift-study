import SwiftUI

class PostData: ObservableObject {
    @Published var sample: [(String, String)] = [
        ("1", "pencil"),
        ("2", "pencil"),
        ("3", "pencil")
    ]
    @Published var data: [(String, UIImage?)] = [
    ]
}
