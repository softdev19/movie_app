//
//  CollectionCell.swift
//  ImdbApp
//
//  Created by Ivan Lyaskovets on 04.10.2022.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    
    public static let identifier = "collectionCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
