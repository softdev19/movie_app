//
//  CollectionCell.swift
//  ImdbApp
//
//  Created by Ivan Lyaskovets on 04.10.2022.
//

import UIKit
import SnapKit
import SDWebImage

class CollectionCell: UICollectionViewCell {
    
    //MARK: --Properties
    public static let identifier = "collectionCell"
    
    lazy private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    //MARK: --Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: --Functions
    private func setupView(){
        imageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.bottom.equalTo(contentView.snp.bottom)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
        }
    }
    
    func configureCell(with imagePath: String){
        guard let url = URL(string: imagePath) else {return}
        imageView.sd_setImage(with: url, completed: nil)
    }

}
