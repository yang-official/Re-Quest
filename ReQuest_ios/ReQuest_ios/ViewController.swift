//
//  ViewController.swift
//  ReQuest_ios
//
//  Created by Leon Mak on 9/9/17.
//  Copyright © 2017 Leon Mak. All rights reserved.
//

import UIKit
import SatoriRtmSdkWrapper

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Satori.instance.initialize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
}
