//
//  HomeTableCell.swift
//  ImdbApp
//
//  Created by Ivan Lyaskovets on 30.09.2022.
//

import UIKit

class TableCell: UITableViewCell {

    //MARK: --Properties
    public static let identifier = "tableCell"
    
    lazy private var collectionView: UICollectionView = {
        //Layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 200)
        //CV
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.identifier)
        return collectionView
    }()
    
    private var videos: [Video] = []

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
        
        contentView.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        setupCollection()
    }
    
    private func setupCollection(){
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.bottom.equalTo(contentView.snp.bottom)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
        }
    }
    
    func configureCell(with videos: [Video]){
        self.videos = videos
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}


//MARK: --UICollectionViewDataSource
extension TableCell: UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.identifier, for: indexPath) as? CollectionCell else {return UICollectionViewCell()}
        if let imagePath = videos[indexPath.item].image{
            cell.configureCell(with: imagePath)
        }
        else{
            cell.backgroundColor = .systemCyan
        }
        
        return cell
    }
}


//MARK: --UICollectionViewDelegate
extension TableCell: UICollectionViewDelegate{

}
