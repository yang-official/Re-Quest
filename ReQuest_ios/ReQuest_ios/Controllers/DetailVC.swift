//
//  DetailVC.swift
//  ReQuest_ios
//
//  Created by Leon Mak on 10/9/17.
//  Copyright © 2017 Leon Mak. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    var quest: Quest?
    
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var userImgView: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
