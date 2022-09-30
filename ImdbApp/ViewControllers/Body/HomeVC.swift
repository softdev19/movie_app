//
//  ViewController.swift
//  ImdbApp
//
//  Created by Ivan Lyaskovets on 28.09.2022.
//

import UIKit
import SnapKit

class HomeVC: UIViewController {
    
    lazy private var tableView: UITableView = {
        let table = UITableView()
        table.frame = .zero
        table.translatesAutoresizingMaskIntoConstraints = false
        table.tableHeaderView = TableHeader(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: 300)))
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setupView(){
        view.backgroundColor = .systemBackground
        title = "Home"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(goToSettingsVC))
        navigationController?.navigationBar.tintColor = .white
        
        view.addSubview(tableView)
        addConstraits()
    }
    
    private func addConstraits(){
        
        tableView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
        }
    }
    
    @objc private func goToSettingsVC(){
        navigationController?.pushViewController(SettingsVC(), animated: true)
    }
    
}

extension HomeVC: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
            case 0: return "IN THEATERS"
            case 1: return "MOST POPULAR MOVIES"
            case 2: return "MOST POPULAR TVS"
            default: break
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemMint
        return cell
    }
}

extension HomeVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}

