//
//  TabBarViewController.swift
//  PhotoProject
//
//  Created by 한수빈 on 1/19/25.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    private let photoSearchViewController = {
        let vc = PhotoSearchViewController()
        vc.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        let nav = UINavigationController(rootViewController: vc)
        return nav
    }()
    
    private let trendingPhotosByTopicViewController = {
        let vc = TrendingPhotosByTopicViewController()
        vc.tabBarItem.image = UIImage(systemName: "chart.line.uptrend.xyaxis")
        let nav = UINavigationController(rootViewController: vc)
        return nav
    }()
    private let randomPhotoViewController = {
        let vc = RandomPhotoViewController()
        vc.tabBarItem.image = UIImage(systemName: "movieclapper")
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.tintColor = .black
        setViewControllers([trendingPhotosByTopicViewController, randomPhotoViewController, photoSearchViewController], animated: true)
        
    }
    

}


extension TabBarViewController: UITabBarControllerDelegate {
    
}

