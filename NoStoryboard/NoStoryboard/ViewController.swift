import UIKit

class ViewController: UIViewController {
    
    let label = UILabel()
    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        
        // 버튼의 타겟 메서드 지정
        button.addTarget(self, action: #selector(nextBtnTapped), for: .touchUpInside)
    }
    
    func initView(){
        view.backgroundColor = .white
        
        label.text = "첫 화면"
        label.textAlignment = .center // 텍스트 가운데 정렬
        
        button.setTitle("다음", for: .normal)
        button.backgroundColor = .blue
        
        // Auto Layout을 사용하여 label을 화면 중앙에 배치
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        // Auto Layout을 사용하여 button을 label 아래에 배치
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc func nextBtnTapped(){
        let secondVC = SecondViewController()
        navigationController?.pushViewController(secondVC, animated: true)
    }
}

