
import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let viewTitle  = UILabel()
    let imageSearchTextField = UITextField()
    let imageView = UIImageView()
    let separatorView = UIView()
    
    let imagedata = Data.list

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        initView()
        imageSearchTextField.delegate = self
        
        imageSearchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    func initView(){
        view.addSubview(viewTitle)
        view.addSubview(imageSearchTextField)
        view.addSubview(imageView)
        view.addSubview(separatorView)
        
        imageSearchTextField.placeholder = "Enter the name"
        imageSearchTextField.textAlignment = .center
        
        
        viewTitle.text = "WIKIFRUIT"
        viewTitle.font = .boldSystemFont(ofSize: 35)
        
        separatorView.backgroundColor = .black
        
        
        viewTitle.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(80)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        imageSearchTextField.snp.makeConstraints{make in
            make.top.equalTo(viewTitle.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        imageView.snp.makeConstraints{make in
            make.top.equalTo(imageSearchTextField.snp.bottom).offset(60)
            make.centerX.equalToSuperview()
            make.width.equalTo(350)
            make.height.equalTo(500)
        }
        
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(imageSearchTextField.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(1)
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let enteredText = textField.text?.lowercased() {
            if let imageData = imagedata.first(where: { $0.name.lowercased() == enteredText }) {
                imageView.image = imageData.image
            } else {
                imageView.image = nil
            }
        }
    }
}

extension ViewController: UITextFieldDelegate{

//    //enter 키 눌렀을 때 작동
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()//enter 키 누를 때 키보드 닫기
//
//        if let enteredText = textField.text?.lowercased() {
//            if let imageData = imagedata.first(where: { $0.name.lowercased() == enteredText }) {
//                imageView.image = UIImage(named: textField.text!.lowercased())
//            } else {
//                imageView.image = nil
//            }
//        }
//
//        return true
//    }
}
