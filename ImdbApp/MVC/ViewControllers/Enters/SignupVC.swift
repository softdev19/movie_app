//
//  SignupVC.swift
//  ImdbApp
//
//  Created by Ivan Lyaskovets on 28.09.2022.
//

import UIKit
import SnapKit
import FirebaseAuth
import FirebaseFirestore

class SignupVC: UIViewController {
    
    //MARK: --Properties
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

    //MARK: --LifeCycleOfViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func validateFields()->String?{
        
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Error: some fields are empty. Please check it and try again"
        }
        
//        if isFirstNameValid(firstNameTextField.text!) == false{
//            return "Error: incorrect firstName"
//        }
//
//        if isLastNameValid(lastNameTextField.text!) == false{
//            return "Error: incorrect lastName"
//        }
        
        if isEmailValid(emailTextField.text!) == false{
            return "Error: incorrect email"
        }
        
        if isPasswordValid(passwordTextField.text!) == false{
            return "Error: incorrect password"
        }
        
        return nil
        
    }
    
    private func isFirstNameValid(_ firstName: String)->Bool{
        let test = NSPredicate(format: "SELF MATCHES %@", "")
        return test.evaluate(with: firstName)
    }
    
    private func isLastNameValid(_ lastName: String)->Bool{
        let test = NSPredicate(format: "SELF MATCHES %@", "")
        return test.evaluate(with: lastName)
    }
    
    private func isEmailValid(_ email: String)->Bool{
        let test = NSPredicate(format: "SELF MATCHES %@", "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$")
        return test.evaluate(with: email)
    }
    
    private func isPasswordValid(_ password: String)->Bool{
        let test = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return test.evaluate(with: password)
    }

    
    //MARK: --Functions
    @objc private func goToMainVC(){
        
        let error = validateFields()
        if error != nil{
            showError(error!)
        }
        else{
            
            let cleanFirstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let cleanLastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let cleanEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let cleanPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: cleanEmail, password: cleanPassword) { result, error in
                if error != nil{
                    self.showError("Error: invalid registration")
                }
                else{
                    let uid = result?.user.uid
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["uid": uid, "firstname": cleanFirstName, "lastname": cleanLastName]) { error in
                        if error != nil{
                            self.showError("Error: invalid saving data")
                        }
                        else{
                            self.view.window?.rootViewController = MainVC()
                            self.view.window?.makeKeyAndVisible()
                        }
                    }
                    
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
