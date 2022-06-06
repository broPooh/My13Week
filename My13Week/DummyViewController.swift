//
//  DummyViewController.swift
//  My13Week
//
//  Created by bro on 2022/06/05.
//

import UIKit

class DummyViewController: UIViewController {
    
    let tableView = UITableView()
    
    let viewModel = DummyViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
        
        
    }
    


}

extension DummyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .value1, reuseIdentifier: UITableViewCell.reuseIdentifier)
//        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
//        //cell.textLabel?.text = castData?.peopleListResult.peopleList[indexPath.row].peopleNm
//        //cell.detailTextLabel?.text = "ssss"
//        return cell
        viewModel.cellForRowAt(tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.hegihtOfRowAt
    }
    
    
}

