//
//  UITableViewCell+Extention.swift
//  My13Week
//
//  Created by bro on 2022/06/05.
//

import UIKit

protocol ResuableView {
    static var reuseIdentifier: String { get }
}


extension UITableViewCell: ResuableView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
}
