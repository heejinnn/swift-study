import SnapKit
import UIKit

class ResolutionViewController: UIViewController {

    let headerView = UIView()
    let headerTitle = UILabel()
    let popupBtn = UIButton()
    
    let resolutionTableView = UITableView()
    var resolutions = [Data]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        resolutionTableView.dataSource = self
        resolutionTableView.delegate = self
        
        resolutionTableView.register(ResolutionTableViewCell.self, forCellReuseIdentifier: "ResolutionTableViewCell")
        
        popupBtn.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        
        initView()
        
        resolutions = Data.list
        resolutionTableView.reloadData()
    }
    
    
    func initView(){
        
        headerView.addSubview(headerTitle)
        headerView.addSubview(popupBtn)
        
        view.addSubview(headerView)
        view.addSubview(resolutionTableView)
        
        headerTitle.text = "New Year's resolution"
        headerTitle.font = .boldSystemFont(ofSize: 20)
        
        popupBtn.setTitle("+", for: .normal)
        popupBtn.setTitleColor(.red, for: .normal)
        popupBtn.titleLabel?.font = .boldSystemFont(ofSize: 35)
        
        headerView.layer.borderWidth = 0.3
        
        headerView.snp.makeConstraints{make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(120)
        }
        
        headerTitle.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(70)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        popupBtn.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(68)
            make.trailing.equalTo(headerView.snp.trailing).offset(-20)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        
        resolutionTableView.snp.makeConstraints{make in
            make.top.equalTo(headerView.snp.bottom)
            make.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    @objc private func showAlert() {
        let alertController = UIAlertController(title: "New Resolution", message: nil, preferredStyle: .alert)
        
        // UITextField 추가
        alertController.addTextField { textField in
            textField.placeholder = "입력하세요"
        }
        
        // 버튼 추가
        let cancelButton = UIAlertAction(title: "Cancle", style: .cancel, handler: nil)
        let confirmButton = UIAlertAction(title: "Confirm", style: .default) { _ in
            // 확인 버튼이 눌렸을 때의 동작
            if let textField = alertController.textFields?.first {
                print("입력값: \(textField.text ?? "")")
                let newResolution = Data(id: self.resolutions.count + 1, content: textField.text!)
                self.resolutions.append(newResolution)
                self.resolutionTableView.reloadData()
            }
        }
        
        // 버튼을 UIAlertController에 추가
        alertController.addAction(cancelButton)
        alertController.addAction(confirmButton)
        
        // UIAlertController를 present
        present(alertController, animated: true, completion: nil)
    }
}

extension ResolutionViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resolutions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResolutionTableViewCell", for: indexPath) as! ResolutionTableViewCell
        
        let cellData = resolutions[indexPath.row]
        cell.configure(data: cellData.content)
        
        return cell
    }
}

extension ResolutionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //오른쪽 스와이프 삭제
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //UIContextualAction 클로저 매개변수
        //첫 번째: 스와이프 작업 발생한 셀의 인덱스
        //두 번째: 스와이프 작업 발생한 셀의 정보
        //completionHandler: 클로저가 실행을 완료했을 때 호출되는 핸들러
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
            // 스와이프 삭제 버튼이 눌렸을 때의 동작
            self.resolutions.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)//fade 스타일 적용
            completionHandler(true)//스와이프 작업 완료되었음을 알림
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
