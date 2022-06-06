//
//  DummyData.swift
//  My13Week
//
//  Created by bro on 2022/06/05.
//

import Foundation
import UIKit

class DummyViewModel {
    var data: [String] = Array(repeating: "테스트", count: 100)
}

extension DummyViewModel: TableViewCellRepresentable {
    var numberOfSection: Int {
        return 1
    }
    
    var numberOfRowsInSection: Int {
        return data.count
    }
    
    var hegihtOfRowAt: CGFloat {
        return 60
    }
    
    func cellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    var rowCount: Int {
        return data.count
    }
    
    var rowHeight: CGFloat {
        return 50
    }
    
    //func cell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}
