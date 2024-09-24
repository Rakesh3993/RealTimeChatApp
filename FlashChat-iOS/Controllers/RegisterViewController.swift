//
//  RegisterViewController.swift
//  FlashChat-iOS
//
//  Created by Rakesh Kumar on 01/05/24.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    private var emailTextFieldImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "textfield")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var passwordTextFieldImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "textfield")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    
    private var registerButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Register", for: .normal)
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        button.setTitleColor(.darkdarkgreen, for: .normal)
        return button
    }()
    
    private var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Email"
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.isUserInteractionEnabled = true
        return textField
    }()
    
    private var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.isUserInteractionEnabled = true
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightlightgreen
        [emailTextFieldImageView, passwordTextFieldImageView, emailTextField, passwordTextField, registerButton].forEach(view.addSubview)
        addConstraints()
    }
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
            emailTextFieldImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            emailTextFieldImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: emailTextFieldImageView.topAnchor, constant: 22),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            passwordTextFieldImageView.topAnchor.constraint(equalTo: emailTextFieldImageView.bottomAnchor, constant: -30),
            passwordTextFieldImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordTextFieldImageView.topAnchor, constant: 25),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            registerButton.topAnchor.constraint(equalTo: passwordTextFieldImageView.bottomAnchor, constant: 10),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc func registerButtonTapped(){
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    print(error)
                }else{
                    let vc = ChatViewController()
                    vc.modalPresentationStyle = .fullScreen
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
}
