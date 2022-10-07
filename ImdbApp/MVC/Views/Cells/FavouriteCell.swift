//
//  FavouriteCell.swift
//  ImdbApp
//
//  Created by Ivan Lyaskovets on 04.10.2022.
//

import UIKit
import SDWebImage

class FavouriteCell: UITableViewCell {

    //MARK: --Properties
    public static let identifier = "favoriteCell"
    
    private lazy var bannerView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(titlelabel)
        stackView.addArrangedSubview(yearlabel)
        stackView.spacing = 5
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var titlelabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private lazy var yearlabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()

    
    //MARK: --Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: --Functions
    private func setupView(){
        
        contentView.addSubview(bannerView)
        bannerView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.left.equalTo(contentView.snp.left)
            make.height.equalTo(180)
            make.width.equalTo(120)
        }
        
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.left.equalTo(bannerView.snp.right).inset(-20)
            make.right.equalTo(contentView.snp.right).inset(20)
        }
    }
    
    public func configureCell(with video: CoreVideo){
        titlelabel.text = video.title
        yearlabel.text = video.year
        guard let imagePath = video.image else {return}
        guard let imageUrl = URL(string: imagePath) else {return}
        bannerView.sd_setImage(with: imageUrl, completed: nil)
    }
    
}
