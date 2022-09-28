//
//  StartVC.swift
//  ImdbApp
//
//  Created by Ivan Lyaskovets on 28.09.2022.
//

import UIKit
import SnapKit
import AVKit

class StartVC: UIViewController {
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginButton, signupButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("LOG IN", for: .normal)
        button.layer.cornerRadius = 20.0
        button.backgroundColor = .systemGreen
        button.tintColor = .white
        return button
    }()
    
    lazy var signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SIGN UP", for: .normal)
        button.layer.cornerRadius = 20.0
        button.backgroundColor = .lightGray
        button.tintColor = .white
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let filePath = Bundle.main.path(forResource: "bg", ofType: "mp4") else {return}
        let url = URL(fileURLWithPath: filePath)
        let item = AVPlayerItem(url: url)
        let player = AVPlayer(playerItem: item)
        let layer = AVPlayerLayer(player: player)
        
        layer.frame = CGRect(x: -self.view.frame.size.width,
                            y: 0,
                            width: self.view.frame.width*4,
                            height: self.view.frame.size.height)
        
        self.view.layer.insertSublayer(layer, at: 0)
        player.playImmediately(atRate: 0.7)
    }  
    
    private func setupView(){
        view.backgroundColor = .white
        
        view.addSubview(stackView)
        addConstraits()
    }
    
    private func addConstraits(){
        
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        signupButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        stackView.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(20)
            make.leading.equalTo(self.view.snp.leading).inset(40)
            make.trailing.equalTo(self.view.snp.trailing).inset(40)
        }
    }
}
