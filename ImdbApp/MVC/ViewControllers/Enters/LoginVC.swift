//
//  LoginVC.swift
//  ImdbApp
//
//  Created by Ivan Lyaskovets on 28.09.2022.
//

import UIKit
import SnapKit
import FirebaseAuth

class LoginVC: UIViewController {
    
    //MARK: --Properties
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, button, errorLabel])
        stackView.axis = .vertical
        stackView.spacing = 15
        return stackView
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
        button.setTitle("Log in", for: .normal)
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

    //MARK: --LifeCycleOfViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    //MARK: --Functions
    private func validateFields()->String?{
        
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Error: some fields are empty. Please check it and try again"
        }
 
        if isEmail(emailTextField.text!) == false{
            return "Error: incorrect email"
        }
        
        if isPasswordValid(passwordTextField.text!) == false{
            return "Error: incorrect password"
        }
        
        return nil
    }
    
    private func isEmail(_ email: String)->Bool{
        let emailTest = NSPredicate(format: "SELF MATCHES %@","^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$")
        return emailTest.evaluate(with: email)
    }
    
    private func isPasswordValid(_ password: String)->Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@","^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }

    
    @objc private func goToMainVC(){
        
        let error = validateFields()
        if error != nil{
            showError(error!)
        }
        else{
            let cleanEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let cleanPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().signIn(withEmail: cleanEmail, password: cleanPassword) { result, error in
                if error != nil{
                    self.showError("Error: incorrect email or password, or such user doesn't exist.")
                }
                else{
                    self.view.window?.rootViewController = MainVC()
                    self.view.window?.makeKeyAndVisible()
                }
            }
        }
    }
    
    private func showError(_ message: String){
        errorLabel.alpha = 1
        errorLabel.text = message
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
