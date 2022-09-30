//
//  TableHeader.swift
//  ImdbApp
//
//  Created by Ivan Lyaskovets on 30.09.2022.
//

import UIKit
import SnapKit

class TableHeader: UIView{
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        
        backgroundColor = .systemCyan
        
//        addSubview(imageView)
//
//        imageView.snp.makeConstraints { make in
//            make.centerX.equalTo(self.snp.centerX)
//            make.centerY.equalTo(self.snp.centerY)
//            make.top.equalTo(self.snp.top)
//            make.bottom.equalTo(self.snp.bottom)
//            make.left.equalTo(self.snp.left)
//            make.right.equalTo(self.snp.right)
//        }
    }

}
