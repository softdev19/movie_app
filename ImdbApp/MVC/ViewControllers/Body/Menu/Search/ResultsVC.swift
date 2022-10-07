//
//  ResultsVC.swift
//  ImdbApp
//
//  Created by Ivan Lyaskovets on 05.10.2022.
//

import UIKit
import SnapKit

protocol ResultCellDelegate: AnyObject{
    func cellTapped(with model: DetailedVideoModel)
}

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
    
    weak var delegate: ResultCellDelegate?

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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let video = videos[indexPath.item]
        
        APIManager.shared.getDataFromYoutube(with: "\(video.title) \(video.year ?? "") trailer") { response in
            switch response{
                case .success(let youtubeVideo):
                    self.delegate?.cellTapped( with: DetailedVideoModel(title: video.title, year: video.year ?? "", video: youtubeVideo.videoId))
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let config = UIContextMenuConfiguration(identifier: nil,
                                                previewProvider: nil) { _ in
            let addToFavourites = UIAction(title: "Add to favourites",
                                           image: UIImage(systemName: "star"),
                                           identifier: nil,
                                           discoverabilityTitle: nil,
                                           attributes: [],
                                           state: .off) { _ in
                let video = self.videos[indexPath.item]
                LocalDataManager.shared.addData(with: video)
                NotificationCenter.default.post(name: NSNotification.Name("AddToFavourites"), object: nil)
            }
            
            return UIMenu(title: "",
                          subtitle: nil,
                          image: nil,
                          identifier: nil,
                          options: .displayInline,
                          children: [addToFavourites])
        }
        return config
    }
}

