//
//  ViewController.swift
//  SearchTableView
//
//  Created by 최희진 on 2023/09/30.
//

import UIKit

class CandySearch: UIViewController {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var dataTableView: UITableView!
    @IBOutlet weak var candySegment: UISegmentedControl!
    
    let dataArr: [Data] = Data.list
    var segmentData = [Data]()
    var segmented = false
    var filterData = [Data]()//검색된 데이터
    var filtered = false //검색 여부
    
    
    var filterSession: String?
   
    override func viewDidLoad() {
        super.viewDidLoad()

        dataTableView.delegate = self
        dataTableView.dataSource = self
        
        searchTextField.delegate = self
        self.searchTextField.addTarget(self, action: #selector(textFieldDidChanacge), for: .editingChanged)
        
        candySegment.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
        
        registerXib()
        setup()

    }
    
    // segment 값 변경 시 호출되는 메서드
    @objc func segmentValueChanged(_ sender: UISegmentedControl) {
        segmented = true
        
        // 선택된 segment의 title을 가져옴
        let selectedSegmentTitle = sender.titleForSegment(at: sender.selectedSegmentIndex)

        if selectedSegmentTitle == "All" {
            // "All" 세그먼트가 선택된 경우, filterSession를 nil로 설정하여 모든 데이터를 표시
            filterSession = nil
        } else {
            filterSession = selectedSegmentTitle
        }

        // 필터링된 데이터를 적용하고 테이블 뷰를 다시 로드
        segmentfilterData()
    }

    // session에 따라 데이터 필터링
    private func segmentfilterData() {
        if let session = filterSession {
            segmentData = dataArr.filter { $0.session == session }
        } else {
            // filterSession이 nil이면 모든 데이터를 표시
            segmentData = dataArr
        }

        dataTableView.reloadData()
    }

    
    @objc func textFieldDidChanacge() {
        let textCount = searchTextField.text?.count //textField의 글자수를 저장
        if(textCount == 0){//textField이 빈값인 경우
            filtered = false
            filterData.removeAll()
            dataTableView.reloadData()
        }
    }
    
    private func registerXib() {
        let nibName = UINib(nibName: "DataTableViewCell", bundle: nil)
        dataTableView.register(nibName, forCellReuseIdentifier: "DataTableViewCell")
    }
    
    
    func setup(){
        searchTextField.borderStyle = .roundedRect
        searchTextField.clearButtonMode = .always // 전체 삭제버튼
    }


}
extension CandySearch: UITextFieldDelegate{
    
    //키보드 리턴 or 엔터 키
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

           if textField == self.searchTextField {
               if let text = searchTextField.text{
                   
                   if !textField.text!.trimmingCharacters(in: .whitespaces).isEmpty { // 공백 아닌 문자열이 있을 경우
                       filterText(text)
                   }
               }
           }
           searchTextField.endEditing(true) //키패드 닫기
        
           return true

    }
    
    //textField에 공백 아닌 문자열이 있는 경우
      func filterText(_ query : String){
          filterData.removeAll()//중복 제거
          
          //입력된 text가 name과 일치한다면 filterData에 추가
          
          if segmentData.count != 0{
              for array in segmentData {
                  if array.name.lowercased().contains(query.lowercased()) {
                      filterData.append(array)
                  }
              }
          } else {
              for array in dataArr {
                  if array.name.lowercased().contains(query.lowercased()) {
                      filterData.append(array)
                  }
              }
          }
          
          filtered = true
          dataTableView.reloadData()
      }
}

extension CandySearch: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataTableViewCell", for: indexPath) as! DataTableViewCell
           
        if filterData.count != 0{//검색한 내용이 있다면
            
            if self.filterData.count > 0 {
                let cellData = filterData[indexPath.row]
                cell.configure(data: cellData.name)
            }
        }
        
        else {
    
            if segmentData.count != 0 {
                let cellData = segmentData[indexPath.row]
                cell.configure(data: cellData.name)
                
            }else{
                let cellData = dataArr[indexPath.row]
                cell.configure(data: cellData.name)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filterData.count != 0 {
            return filterData.count
        } else if filterData.count == 0 && filtered == true {
            return 0
        }
        return segmented ? segmentData.count : dataArr.count
        
    }
}


extension CandySearch: UITableViewDelegate{
    //셀 클릭시 색상 원래로 돌아오기
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "CandyInfo") as? CandyInfo else { return }
        if segmented == true{
            nextVC.data = segmentData[indexPath.row].name
        } else{
            nextVC.data = dataArr[indexPath.row].name
        }
        
        self.navigationController?.pushViewController(nextVC, animated: false)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50 // 각 UITableViewCell의 높이를 설정
    }
}


