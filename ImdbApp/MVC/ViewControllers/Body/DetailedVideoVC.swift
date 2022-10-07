//
//  DetailedVideoVC.swift
//  ImdbApp
//
//  Created by Ivan Lyaskovets on 07.10.2022.
//

import UIKit
import SnapKit
import YouTubeiOSPlayerHelper

class DetailedVideoVC: UIViewController {
    
    private lazy var player: YTPlayerView = {
        let player = YTPlayerView()
        return player
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, yearLabel])
        stackView.spacing = 5
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView(){
        view.backgroundColor = .systemBackground
        view.addSubview(player)
        view.addSubview(stackView)
        
        player.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(300)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(player.snp.bottom).inset(-30)
        }
    }
    
    func configureView(with detailedVideo: DetailedVideoModel){
        titleLabel.text = detailedVideo.title
        yearLabel.text = detailedVideo.year
        player.load(withVideoId: detailedVideo.video ?? "")
    }
}
