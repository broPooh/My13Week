//
//  SignViewModel.swift
//  My13Week
//
//  Created by bro on 2022/06/06.
//

import Foundation
import UIKit

class SignViewModel {
    
    var navigationTitle: String = "네비게이션 타이틀"
    var buttonTitle: String = "Sign up"
    
    fileprivate func didTapButton(completion: @escaping () -> Void) {
        completion()
    }
    
    var text: String = "고래밥" {
        
        didSet {
            let count = text.count
            let value = count >= 100 ? "작성할 수 없습니다." : "\(count)/100"
            let color: UIColor = count >= 100 ? .red : .black
            listener?(value, color)
        }
        
    }
    
    var listener: ((String, UIColor) -> Void)?
    
    func bind(listener: @escaping (String, UIColor) -> Void) {
        self.listener = listener
    }
    
}
