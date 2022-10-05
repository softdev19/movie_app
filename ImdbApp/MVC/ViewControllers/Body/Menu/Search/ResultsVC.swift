//
//  ResultsVC.swift
//  ImdbApp
//
//  Created by Ivan Lyaskovets on 05.10.2022.
//

import UIKit
import SnapKit

class ResultsVC: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        //Layout
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.scrollDirection = .vertical
        
        let itemPerRow: CGFloat = 3
        let fullWidth = UIScreen.main.bounds.width
        let availableWidth = fullWidth - layout.sectionInset.left * (itemPerRow + 1)
        let itemWidth = availableWidth / itemPerRow
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.5)
        
        //CV
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.identifier)
        return collection
    }()
    
    public var videos = [Video]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name("SearchResponseRecieved"), object: nil)
    }
    
    @objc private func reloadData(){
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    private func setupView(){
        view.backgroundColor = .systemBackground
        
        view.addSubview(collectionView)
        setupCollectionView()
    }
    
    private func setupCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
        }
    }
}

extension ResultsVC: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.identifier, for: indexPath) as? CollectionCell else {return UICollectionViewCell()}
        let video = videos[indexPath.row]
        cell.configureCell(with: video.image!)
        return cell
    }
}

extension ResultsVC: UICollectionViewDelegate{
    
}

