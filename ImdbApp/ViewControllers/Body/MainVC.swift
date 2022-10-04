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
        let downloadsVC = UINavigationController(rootViewController: DownloadsVC())
        
        //Добавить название
        homeVC.tabBarItem.title = "Home"
        searchVC.tabBarItem.title = "Search"
        downloadsVC.tabBarItem.title = "Downloads"
        
        //Добавить картинку
        homeVC.tabBarItem.image = UIImage(systemName: "house")
        searchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        downloadsVC.tabBarItem.image = UIImage(systemName: "arrow.down.circle")
        
        //Добавить viewControllers на TabBarController
        setViewControllers([homeVC,searchVC,downloadsVC], animated: true)
    }
}
