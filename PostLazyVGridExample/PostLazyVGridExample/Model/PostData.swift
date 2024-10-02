import SwiftUI

class PostData: ObservableObject {

    @Published var data: [(String, UIImage?)] = [
        ("First Post", UIImage(named: "sample")),
        ("Second Post", UIImage(systemName: "pencil")),
        ("Third Post", UIImage(systemName: "pencil")),
        ("Fourth Post", UIImage(systemName: "pencil"))
    ]
}
