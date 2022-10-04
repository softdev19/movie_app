//
//  FavouritesVC.swift
//  ImdbApp
//
//  Created by Ivan Lyaskovets on 28.09.2022.
//

import UIKit
import SnapKit

class FavouritesVC: UIViewController {
    
    lazy private var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "favouriteCell")
        return table
    }()
    
    private var videos: [CoreVideo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        fetchDataFromLocalStorage()
    }
    
    private func fetchDataFromLocalStorage(){
        
        LocalDataManager.shared.fetchData { response in
            switch response{
            case .success(let videos):
                self.videos = videos
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func setupView(){
        
        title = "Favourites"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        setupTableView()
    }
    
    private func setupTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
        }
    }
}

extension FavouritesVC: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favouriteCell", for: indexPath)
        cell.textLabel?.text = "\(videos[indexPath.row].title)"
        return cell
    }
}

extension FavouritesVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete", handler: {_,_,_ in
            LocalDataManager.shared.deleteData(video: self.videos[indexPath.row]) { response in
                switch response{
                    case .success(): return
                    case .failure(let error): print(error.localizedDescription)
                }
            }
            
            self.fetchDataFromLocalStorage()
        })
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
