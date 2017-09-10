//
//  NavBarController.swift
//  ReQuest_ios
//
//  Created by Leon Mak on 9/9/17.
//  Copyright © 2017 Leon Mak. All rights reserved.
//

import UIKit
import ChameleonFramework

class NavBarController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.isTranslucent = true
        self.navigationBar.barTintColor = UIColor.flatGray
        
        self.navigationBar.tintColor = UIColor.flatWhiteDark
        self.navigationItem.title = "Re-Quest"

    }
}
