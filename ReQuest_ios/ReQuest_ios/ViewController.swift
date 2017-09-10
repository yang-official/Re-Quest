//
//  ViewController.swift
//  ReQuest_ios
//
//  Created by Leon Mak on 9/9/17.
//  Copyright © 2017 Leon Mak. All rights reserved.
//

import UIKit
import SatoriRtmSdkWrapper
import ESTabBarController_swift

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupTabController()
    }
    
    func setupTabController() {
        let tabController = ESTabBarController()
        
        let profileVC = ProfileVC()
        let savedVC = SavedVC()
        let findVC = FindVC()
        let historyVC = HistoryVC()
        let addVC = AddVC()

        profileVC.tabBarItem = ESTabBarItem.init(TabBarItemView(), title: "Profile", image: UIImage(named:"profile"))
        historyVC.tabBarItem = ESTabBarItem.init(TabBarItemView(), title: "History", image: UIImage(named:"past"))
        addVC.tabBarItem = ESTabBarItem.init(TabBarItemView(), title: "Add", image: UIImage(named:"add"))
        savedVC.tabBarItem = ESTabBarItem.init(TabBarItemView(), title: "Saved", image: UIImage(named:"current"))
        findVC.tabBarItem = ESTabBarItem.init(TabBarItemView(), title: "Search", image: UIImage(named:"find"))

        tabController.viewControllers = [profileVC, savedVC, findVC, historyVC, addVC]
        
        let navBarController = NavBarController.init(rootViewController: tabController)
        self.present(navBarController, animated: true, completion: nil)
    }
}
