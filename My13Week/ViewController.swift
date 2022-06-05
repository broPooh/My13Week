//
//  ViewController.swift
//  My13Week
//
//  Created by bro on 2022/06/05.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
       
    let tableView = UITableView()
    
    var apiService = APIService()

    var castData: Cast? // 배열이어야 하는 것 아닌가요?
 
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        //apiService.requestCast()
        apiService.requestCastCloser { cast in
            //print(cast)
            self.castData = cast
            
            //메인쓰레드에서 UI를 갱신해야한다.
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return castData?.peopleListResult.peopleList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell.textLabel?.text = castData?.peopleListResult.peopleList[indexPath.row].peopleNm
        cell.detailTextLabel?.text = "ssss"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}

