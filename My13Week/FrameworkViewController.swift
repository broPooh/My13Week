//
//  FrameworkViewController.swift
//  My13Week
//
//  Created by bro on 2022/06/06.
//

import UIKit
import MyFramework

class FrameworkViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let open = FrameOpen()
        
        open.presentWebViewController(url: "http://www.naver.com", transitionStyle: .push, vc: self)
    }

    
}
