//
//  ProfileVC.swift
//  ReQuest_ios
//
//  Created by Leon Mak on 9/9/17.
//  Copyright © 2017 Leon Mak. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSLog("Initializing Satori")
        Satori.instance.initialize()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
