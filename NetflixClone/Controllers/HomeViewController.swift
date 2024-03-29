//
//  HomeViewController.swift
//  NetflixClone
//
//  Created by Gabriel Pereira on 06/01/24.
//

import UIKit

class HomeViewController:UIViewController {
    
    private let homeFeedTable:UITableView = {
        let table = UITableView(frame:.zero,style: .grouped)
        table.register(CollectionViewTableViewCell.self,forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    
    private let moviesData = ["trending movies","trending tv","popular","upcoming movies","top rated"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APICaller().handlerGetMovies()
        view.addSubview(homeFeedTable)
        view.backgroundColor = .systemBackground
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        configureNavBar()
        
        let heightAdaptive = (view.bounds.height / 100) * 45
        let headerView = HeroHeaderUIView(frame:CGRect(x: 0, y: 0, width: view.bounds.width, height: heightAdaptive))
        homeFeedTable.tableHeaderView = headerView
    }
    
    private func configureNavBar(){
        
        var image = UIImage(named: "logo")
        image = image?.withRenderingMode(.alwaysOriginal)
       
        let leftBarButtonSpace = UIBarButtonItem(image: image, style: .plain, target: self, action: nil)
        let leftPosition = view.bounds.width / 4 - 20
        leftBarButtonSpace.imageInsets = UIEdgeInsets(top: 0, left: -leftPosition, bottom: 0, right: 0)

        navigationItem.leftBarButtonItem = leftBarButtonSpace
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image:UIImage(systemName: "person"),style: .done,target: self,action: nil),
            UIBarButtonItem(image:UIImage(systemName: "play.rectangle"),style: .done,target: self,action: nil)
        ]
        navigationController?.navigationBar.tintColor = .white
    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
}

extension HomeViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return moviesData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultoffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultoffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0,-offset))
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.textColor = .white
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y , width: 100, height: header.bounds.height)
        header.textLabel?.text = header.textLabel?.text?.capitalized(with: .none)
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        tableView.tintColor = .white
        
        return moviesData[section]
    }
}
