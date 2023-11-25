import UIKit
import SnapKit

class CollectionViewHeader: UICollectionReusableView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    func initHeader() {
        addSubview(titleLabel)
        
        
        titleLabel.snp.makeConstraints { make in

            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
        }
    }
}

