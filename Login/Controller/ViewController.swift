//
//  ViewController.swift
//  Login
//
//  Created by kiras on 2020/5/26.
//  Copyright © 2020 ameyo. All rights reserved.
//

import UIKit

protocol LoginDidDelegate: class {
    func didButton()
}

class ViewController: UIViewController {
    
    lazy var accountTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .white
        tf.placeholder = "Account"
        tf.layer.cornerRadius = 5
        tf.textAlignment = .center
        tf.delegate = self
        tf.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: .init(width: 160, height: 45))
        return tf
    }()
    
    lazy var passTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .white
        tf.placeholder = "password"
        tf.layer.cornerRadius = 5
        tf.textAlignment = .center
        tf.delegate = self
        tf.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: .init(width: 160, height: 45))
        return tf
    }()
    
    lazy var loginButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 5
        btn.setTitle("LOGIN", for: .normal)
        btn.tintColor = .green
        btn.backgroundColor = .systemBlue
        btn.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: .init(width: 160, height: 45))
        btn.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return btn
    }()
    
    @objc func handleLogin() {
        print("handleLogin")
        self.longDelegate?.didButton()
    }
    
    func setup() {
        let stackView = UIStackView(arrangedSubviews: [accountTextField, passTextField, loginButton])
        stackView.spacing = 8
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 280, left: 20, bottom: 0, right: 20))
    }
    
    weak var longDelegate: LoginDidDelegate?
    var isSuccess: Bool = true
    var viewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
        longDelegate = self
    }
    
}

extension ViewController: LoginDidDelegate {
    
    func didButton() {
        
        guard let account = accountTextField.text else { return }
        guard let passw = passTextField.text else { return }
        
        //print("account, passw", account, passw)
        let login = Login(user_login: account, user_pass: passw)
        
        viewModel.login(login: login)
        
        viewModel.showAlertClosure = {
            self.presentAlert()
        }
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("結束編輯")
    }
}

extension ViewController {
    private func presentAlert() {
        let alertCV = UIAlertController(title: "登入失敗", message: "Please re-type password", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertCV.addAction(action)
        
        present(alertCV, animated: true, completion: nil)
    }
}

