//
//  SignupVC.swift
//  ImdbApp
//
//  Created by Ivan Lyaskovets on 28.09.2022.
//

import UIKit
import SnapKit

class SignupVC: UIViewController {
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstNameTextField, lastNameTextField, emailTextField, passwordTextField, button, errorLabel])
        stackView.axis = .vertical
        stackView.spacing = 15
        return stackView
    }()
    
    lazy var firstNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "First name.."
        return tf
    }()
    
    lazy var lastNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Last name.."
        return tf
    }()
    
    lazy var emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email.."
        return tf
    }()
    
    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password.."
        return tf
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign up", for: .normal)
        button.addTarget(self, action: #selector(goToMainVC), for: .touchUpInside)
        button.tintColor = .white
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 15.0
        return button
    }()
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Error"
        label.textColor = .systemRed
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @objc private func goToMainVC(){
        self.view.window?.rootViewController = MainVC()
        self.view.window?.makeKeyAndVisible()
    }
    
    private func setupView(){
        view.backgroundColor = .systemBackground
        errorLabel.alpha = 0
        
        view.addSubview(stackView)
        addConstraits()
    }
    
    private func addConstraits(){
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        firstNameTextField.snp.makeConstraints { make in
            make.height.equalTo(emailTextField.snp.height)
        }
        
        lastNameTextField.snp.makeConstraints { make in
            make.height.equalTo(emailTextField.snp.height)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(emailTextField.snp.height)
        }
        
        button.snp.makeConstraints { make in
            make.height.equalTo(emailTextField.snp.height)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.leading.equalTo(view.snp.leading).inset(40)
            make.trailing.equalTo(view.snp.trailing).inset(40)
        }
        
        
    }

}
