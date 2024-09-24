//
//  ViewController.swift
//  FlashChat-iOS
//
//  Created by Rakesh Kumar on 01/05/24.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {
    
    private var chatLabel: CLTypingLabel = {
        let label = CLTypingLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "⚡FlashChat"
        label.font = UIFont.systemFont(ofSize: 40, weight: UIFont.Weight(20))
        label.textColor = .darkdarkgreen
        label.layer.borderColor = UIColor.black.cgColor
        return label
    }()
    
    private var loginButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .lightblue
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private var registerButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .lightgreen
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitle("Register", for: .normal)
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightlightgreen
        [chatLabel, registerButton, loginButton].forEach(view.addSubview)
        addConstraints()
    }
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
            chatLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            chatLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            registerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            
            loginButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 10),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
    }
    
    @objc func loginButtonTapped(){
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func registerButtonTapped(){
        let vc = RegisterViewController()
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
}

