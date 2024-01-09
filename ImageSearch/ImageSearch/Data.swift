import UIKit

struct Data {
    var id : Int
    let name : String
    let image: UIImage
}

extension Data{
    static let list: [Data] = [
       Data(id: 1, name: "apple", image: UIImage(named: "apple")!),
       Data(id: 2, name: "grape", image: UIImage(named: "grape")!),
       Data(id: 3, name: "mango", image: UIImage(named: "mango")!)
    ]
}
