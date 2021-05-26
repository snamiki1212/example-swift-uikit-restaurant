//
//  MainTabBarController.swift
//  Restaurant
//
//  Created by shunnamiki on 2021/05/26.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let categoryVC: UINavigationController = {
            let vc = CategoryTableViewController()
            vc.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
            return UINavigationController(rootViewController: vc)
        }()
        
        let xyzVC: UINavigationController = {
            let vc = XYZViewController()
            vc.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
            return UINavigationController(rootViewController: vc)
        }()
        
        viewControllers = [categoryVC, xyzVC]
    }
}
