//
//  SignViewController.swift
//  My13Week
//
//  Created by bro on 2022/06/05.
//

import UIKit

class SignViewController: BaseViewController {
    
    var mainView = SignView()
    var viewModel = SignViewModel()
    
    //뷰컨트롤러의 루트뷰를 로드할때 호출되는 메서드
    //새로운 뷰를 반환해서 사용하려고 할 때 사용
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.bind { text, color in
            self.mainView.emailTextField.text = text
            self.mainView.emailTextField.textColor = color
        }
        
    }
    
    override func configure() {
        title = viewModel.navigationTitle
        mainView.emailTextField.placeholder = viewModel.text
        mainView.passwordTextField.placeholder = "비밀번호를 작성해주세요"
        mainView.signButton.addTarget(self, action: #selector(signButtonClicked), for: .touchUpInside)
        
        mainView.signButton.setTitle(viewModel.buttonTitle, for: .normal)
    
    }
    
    override func setupConstraints() {
        
    }
    
    @objc func signButtonClicked() {
        print(#function)
        
        guard let text = mainView.emailTextField.text else { return }
        viewModel.text = text
    }
    
}
