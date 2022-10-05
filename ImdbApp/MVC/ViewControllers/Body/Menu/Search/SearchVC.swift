//
//  SearchVC.swift
//  ImdbApp
//
//  Created by Ivan Lyaskovets on 28.09.2022.
//

import UIKit

class SearchVC: UIViewController {
    
    private let searchController = UISearchController(searchResultsController: ResultsVC())

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView(){
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
    }
}

extension SearchVC: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text, !text.trimmingCharacters(in: .whitespaces).isEmpty, text.trimmingCharacters(in: .whitespaces).count >= 3 else {return}
        guard let vc = searchController.searchResultsController as? ResultsVC else {return}
        
        APIManager.shared.search(with: text) { response in
            switch response{
                case .success(let videos):
                    DispatchQueue.main.async{
                        vc.videos = videos
                        NotificationCenter.default.post(name: NSNotification.Name("SearchResponseRecieved"), object: nil)
                }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    
    
    
}


