//
//  StartVC.swift
//  ImdbApp
//
//  Created by Ivan Lyaskovets on 28.09.2022.
//

import UIKit
import SnapKit

class StartVC: UIViewController {
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginButton, signupButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.layer.cornerRadius = 20.0
        button.backgroundColor = .systemGreen
        button.tintColor = .white
        return button
    }()
    
    lazy var signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign up", for: .normal)
        button.layer.cornerRadius = 20.0
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView(){
        view.backgroundColor = .white
        
        view.addSubview(stackView)
        addConstraits()
    }
    
    private func addConstraits(){
        
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        signupButton.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        stackView.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(40)
            make.leading.equalTo(self.view.snp.leading).inset(40)
            make.trailing.equalTo(self.view.snp.trailing).inset(40)
        }
    }
}
