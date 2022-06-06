//
//  TableViewCellRepresentable.swift
//  My13Week
//
//  Created by bro on 2022/06/05.
//

import Foundation
import UIKit

protocol TableViewCellRepresentable {
    
    var numberOfSection: Int { get }
    var numberOfRowsInSection: Int { get }
    var hegihtOfRowAt: CGFloat { get }
    func cellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    
}
