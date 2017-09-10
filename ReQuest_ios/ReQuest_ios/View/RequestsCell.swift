//
//  RequestCell.swift
//  ReQuest_ios
//
//  Created by Leon Mak on 10/9/17.
//  Copyright © 2017 Leon Mak. All rights reserved.
//

import UIKit

class RequestsCell: UITableViewCell {
    
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    var quest: Quest!
    
    func configureCell(quest: Quest) {
        self.quest = quest
        var imageString = "default"
        if let imageFileName = quest.creator.profilePicUrl {
            imageString = imageFileName
        }
        userImg.image = UIImage(named: imageString)
        nameLbl.text = quest.fulfiller.name
        descriptionLbl.text = quest.description
        

    }
    
}
