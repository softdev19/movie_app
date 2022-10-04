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
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(TableCell.self, forCellReuseIdentifier: TableCell.identifier)
        return table
    }()
    
    lazy private var tableHeaderView: UIView = {
        let view = TableHeader(frame: CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: 400)))
        return view
    }()
    
    lazy private var sectionTitles = ["IN THEATERS", "MOST POPULAR MOVIES", "MOST POPULAR TVS"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupView(){
        
        title = "Home"
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(goToSettingsVC))
        navigationController?.navigationBar.tintColor = .label
        
        view.addSubview(tableView)
        setupTableView()
    }
    
    private func setupTableView(){
        
        tableView.tableHeaderView = tableHeaderView
        
        tableView.snp.makeConstraints { make in
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
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.identifier, for: indexPath) as? TableCell else { return UITableViewCell() }
        return cell
    }
}

extension HomeVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.textColor = .label
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
    }

}

