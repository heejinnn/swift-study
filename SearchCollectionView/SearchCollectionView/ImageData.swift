import UIKit

struct ImageData{
    let imageName: String
    let image: UIImage
    let sectionName: String
}

extension ImageData{
    static let list: [ImageData] = [
        ImageData(imageName: "blue", image: UIImage(named: "blue")!, sectionName: "Section1"),
        ImageData(imageName: "red", image: UIImage(named: "red")!, sectionName: "Section1"),
        ImageData(imageName: "purple", image: UIImage(named: "purple")!, sectionName: "Section1"),
        ImageData(imageName: "green", image: UIImage(named: "green")!, sectionName: "Section1"),
        ImageData(imageName: "pink", image: UIImage(named: "pink")!, sectionName: "Section2"),
        ImageData(imageName: "navy", image: UIImage(named: "navy")!, sectionName: "Section2"),
        ImageData(imageName: "yellow", image: UIImage(named: "yellow")!, sectionName: "Section3")
    ]
}

