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
    
    var requester: User!
    var quest: Quest!
    
    func configureCell(requester: User, quest: Quest) {
        self.requester = requester
        self.quest = quest
    }

}
