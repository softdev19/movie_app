//
//  ViewController.swift
//  ImdbApp
//
//  Created by Ivan Lyaskovets on 28.09.2022.
//

import UIKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView(){
        view.backgroundColor = .systemBackground
        title = "Home"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(goToSettingsVC))
        navigationController?.navigationBar.tintColor = .white
    }
    
    @objc private func goToSettingsVC(){
        navigationController?.pushViewController(SettingsVC(), animated: true)
    }
    
    
}

