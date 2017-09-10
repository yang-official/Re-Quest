//
//  QuestCell.swift
//  ReQuest_ios
//
//  Created by Leon Mak on 10/9/17.
//  Copyright © 2017 Leon Mak. All rights reserved.
//

import UIKit

class QuestsCell: UITableViewCell {
    
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    var quest: Quest!
    
    func configureCell(quest: Quest) {
        self.quest = quest
        var imageString = "default"
        if let imageFileName = quest.creator.profilePicUrl {
            imageString = imageFileName
        }
        userImg.image = UIImage(named: imageString)
        titleLbl.text = quest.title
        descriptionLbl.text = quest.description
    }

}
