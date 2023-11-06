import UIKit
import SnapKit

class CollectionViewMain: UIViewController {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let topBarView = UIView()
    let searchInputText = UITextField()
    let seletecItemCount = UILabel()
    
    var sectionData: [String: [ImageData]] = [:]
    var selectedItems: [IndexPath: Bool] = [:]
    let data: [ImageData] = ImageData.list

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        collectionView.delegate = self
        collectionView.dataSource = self
        searchInputText.delegate = self

        organizeDataIntoSections()

        collectionView.register(CollectionViewMainCell.self, forCellWithReuseIdentifier: "CollectionViewMainCell")
        collectionView.register(CollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")//섹션 헤더 등록

        initView()
    }

    private func organizeDataIntoSections() {
        for imageData in ImageData.list {
            if sectionData[imageData.sectionName] == nil {
                sectionData[imageData.sectionName] = []
            }
            sectionData[imageData.sectionName]?.append(imageData)
        }
    }

    private func initView() {
        topBarView.layer.borderWidth = 1
        topBarView.layer.borderColor = UIColor.lightGray.cgColor
        
        searchInputText.placeholder = "Search"
        searchInputText.layer.borderWidth = 1
        searchInputText.layer.borderColor = UIColor.lightGray.cgColor
        searchInputText.layer.cornerRadius = 10
        searchInputText.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 0.0))
        searchInputText.leftViewMode = .always
        searchInputText.font = UIFont.systemFont(ofSize: 15)
        
        seletecItemCount.font = UIFont.systemFont(ofSize: 20)
        seletecItemCount.textColor = .orange
        
        topBarView.addSubview(searchInputText)
        topBarView.addSubview(seletecItemCount)
        view.addSubview(topBarView)
        view.addSubview(collectionView)
        
        searchInputText.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.height.equalTo(40)
            make.width.equalTo(150)
            make.centerX.equalToSuperview()
        }
        seletecItemCount.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(60)
            make.height.equalTo(40)
            make.width.equalTo(150)
            make.leading.equalTo(searchInputText.snp.trailing).offset(10)
        }
        
        topBarView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.height.equalTo(120)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(topBarView.snp.bottom)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
   
    func updateSelectedItemCount() {
        let count = selectedItems.values.filter { $0 == true }.count
        
        if count > 0{
            seletecItemCount.text = "\(count) photo selected"
            
            searchInputText.snp.remakeConstraints { make in
               make.top.equalToSuperview().offset(60)
               make.height.equalTo(40)
               make.width.equalTo(150)
               make.leading.equalTo(view.snp.leading).offset(50)
            }
        }else{
            seletecItemCount.text = ""
                   
            searchInputText.snp.remakeConstraints { make in
                make.top.equalToSuperview().offset(60)
                make.height.equalTo(40)
                make.width.equalTo(150)
                make.centerX.equalToSuperview()
            }
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()//즉시 업데이트
        }
    
    }
}

extension CollectionViewMain: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionName = Array(sectionData.keys)[section]
        return sectionData[sectionName]?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewMainCell", for: indexPath) as! CollectionViewMainCell
        cell.initCell()
        
        let sectionName = Array(sectionData.keys)[indexPath.section]
        let imageData = sectionData[sectionName]?[indexPath.row]
        cell.cellImage.image = imageData?.image
        
        if let isSelected = selectedItems[indexPath], isSelected {
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 4
        } else {
            cell.layer.borderColor = UIColor.clear.cgColor
            cell.layer.borderWidth = 0
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! CollectionViewHeader
            headerView.initHeader()

            let sectionName = Array(sectionData.keys)[indexPath.section]
            headerView.titleLabel.text = sectionName

            return headerView
            
        } else {
            return UICollectionReusableView()
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionData.keys.count
    }
}

extension CollectionViewMain: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            if selectedItems[indexPath] == true {
                // Deselect
                selectedItems[indexPath] = false
            } else {
                // Select
                selectedItems[indexPath] = true
            }
            collectionView.reloadItems(at: [indexPath])
            
            updateSelectedItemCount()
        }
    }
}

extension CollectionViewMain: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 100
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          return CGSize(width: 100, height: 100)
      }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 70, left: 30, bottom: 80, right: 30)
    }
}

extension CollectionViewMain: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let searchText = textField.text, !searchText.isEmpty {
            for (section, _ ) in sectionData {
                if section.lowercased() == searchText.lowercased() {//대소문자 구분없이
                    if let sectionIndex = Array(sectionData.keys).firstIndex(of: section) {
                        let indexPath = IndexPath(item: 0, section: sectionIndex)
                        print(sectionIndex)
                        
                        collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
                    }
                }
            }
        }
        
        textField.resignFirstResponder()//키보드 내리기
        return true
    }
}
