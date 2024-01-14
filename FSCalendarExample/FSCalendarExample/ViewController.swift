import UIKit
import FSCalendar
import SnapKit

class ViewController: UIViewController {
    
    var calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: 320, height: 300))
    var scheduleTableView = UITableView()
    var scheduleManager:[ScheduleManager] = ScheduleManager.list
    var selectedDate: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        initView()
        setupNavigationBar()
        navigationItem.title = "My Calendar"
    }
    
    func initView(){
        calendar.delegate = self
        view.addSubview(calendar)
        
        scheduleTableView.delegate = self
        scheduleTableView.dataSource = self
        scheduleTableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(scheduleTableView)
        
        calendar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.height.equalTo(300)
        }
        
        scheduleTableView.snp.makeConstraints { make in
            make.top.equalTo(calendar.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.height.equalTo(300)
        }
    }
    func setupNavigationBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func didTapAddButton() {
        let alertController = UIAlertController(title: "일정을 입력하세요.", message: "", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Data"
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            guard let textField = alertController.textFields?.first,
                  let data = textField.text else {
                return
            }
            self?.handleDataForSelectedDate(data: data)
        }
        
        alertController.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func handleDataForSelectedDate(data: String) {
        
        if let index = scheduleManager.firstIndex(where: { $0.selectedDate == selectedDate }) {
            scheduleManager[index].dataForDate.append(data)
        }else{
            scheduleManager.append(contentsOf: [ScheduleManager(selectedDate: selectedDate, dataForDate: [data])])
        }
        scheduleTableView.reloadData()
    }

}

extension ViewController: FSCalendarDelegate{
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: date)
        selectedDate = formattedDate
        
        print(scheduleManager)
        scheduleTableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let manager = scheduleManager.first(where: { $0.selectedDate == selectedDate }) {
            return manager.dataForDate.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ScheduleTableViewCell else { fatalError("Unable to dequeue custom cell")}
        
        if let manager = scheduleManager.first(where: { $0.selectedDate == selectedDate }) {
            cell.dataLabel.text = manager.dataForDate[indexPath.row]
        }
        
        return cell
    }
}
