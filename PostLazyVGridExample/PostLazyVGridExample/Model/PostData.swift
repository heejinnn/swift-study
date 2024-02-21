import SwiftUI

class PostData: ObservableObject {

    @Published var data: [(String, UIImage?)] = [
        ("First Post", UIImage(systemName: "pencil")),
        ("Second Post", UIImage(systemName: "pencil")),
        ("Third Post", UIImage(systemName: "pencil")),
        ("Fourth Post", UIImage(systemName: "pencil"))
    ]
}
