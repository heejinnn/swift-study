import UIKit
import SnapKit

class CollectionViewMainCell: UICollectionViewCell {
    let cellImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        return imageView
    }()

    func initCell() {
        addSubview(cellImage)
        
        cellImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

