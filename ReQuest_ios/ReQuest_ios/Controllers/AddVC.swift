//
//  AddVC.swift
//  ReQuest_ios
//
//  Created by Leon Mak on 9/9/17.
//  Copyright © 2017 Leon Mak. All rights reserved.
//

import UIKit
import TextFieldEffects
import ChameleonFramework

class AddVC: UIViewController {
    
    @IBOutlet weak var titleField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.flatWhite
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        titleField.resignFirstResponder()
    }
    
    
}
