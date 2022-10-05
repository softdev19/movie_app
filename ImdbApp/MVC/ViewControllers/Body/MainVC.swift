//
//  MainVC.swift
//  ImdbApp
//
//  Created by Ivan Lyaskovets on 28.09.2022.
//

import UIKit

class MainVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .label
         
        let homeVC = UINavigationController(rootViewController: HomeVC())
        let searchVC = UINavigationController(rootViewController: SearchVC())
        let favouritesVC = UINavigationController(rootViewController: FavouritesVC())
        
        homeVC.tabBarItem.title = "Home"
        searchVC.tabBarItem.title = "Search"
        favouritesVC.tabBarItem.title = "Favourites"
        
        homeVC.tabBarItem.image = UIImage(systemName: "house")
        searchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        favouritesVC.tabBarItem.image = UIImage(systemName: "star")
        
        setViewControllers([favouritesVC], animated: true)
    }
}
