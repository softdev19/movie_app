//
//  SearchVC.swift
//  ImdbApp
//
//  Created by Ivan Lyaskovets on 28.09.2022.
//

import UIKit

class SearchVC: UIViewController {
    
    //MARK: --Properties
    private let searchController = UISearchController(searchResultsController: ResultsVC())

    //MARK: --LifeCycleOfViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: --Functions
    private func setupView(){
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
    }
}


//MARK: --UISearchResultsUpdating
extension SearchVC: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text,
              !text.trimmingCharacters(in: .whitespaces).isEmpty,
              text.trimmingCharacters(in: .whitespaces).count >= 3 else {return}
        
        guard let vc = searchController.searchResultsController as? ResultsVC else {return}
        vc.delegate = self
        
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


//MARK: --ResultCellDelegate
extension SearchVC: ResultCellDelegate{
    
    func cellTapped(with model: DetailedVideoModel) {
        DispatchQueue.main.async {
            let vc = DetailedVideoVC()
            vc.configureView(with: model)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


