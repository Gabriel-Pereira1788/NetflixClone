//
//  ViewController.swift
//  NetflixClone
//
//  Created by Gabriel Pereira on 06/01/24.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        
        let homeNav = UINavigationController(rootViewController: HomeViewController())
        let upcomingNav = UINavigationController(rootViewController: UpcomingViewController())
        let searchNav = UINavigationController(rootViewController: SearchViewController())
        let downloadNav = UINavigationController(rootViewController: DownloadViewController())
        
        
        homeNav.tabBarItem.image = UIImage(systemName: "house.fill")
        upcomingNav.tabBarItem.image = UIImage(systemName: "play.circle")
        searchNav.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        downloadNav.tabBarItem.image = UIImage(systemName: "square.and.arrow.down")
        
        
        homeNav.title = "Home"
        upcomingNav.title = "Coming Soon"
        searchNav.title = "Top Search"
        downloadNav.title = "Download"
        
        tabBar.tintColor = .label
        setViewControllers([homeNav,upcomingNav,searchNav,downloadNav], animated: true)
    }


}

