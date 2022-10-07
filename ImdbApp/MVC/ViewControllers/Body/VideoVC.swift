//
//  VideoVC.swift
//  ImdbApp
//
//  Created by Ivan Lyaskovets on 07.10.2022.
//

import UIKit
import SnapKit


class VideoVC: UIViewController {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel,yearLabel,videoLabel])
        stackView.spacing = 5
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private lazy var videoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView(){
        view.backgroundColor = .systemBackground
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(300)
        }
    }

}
