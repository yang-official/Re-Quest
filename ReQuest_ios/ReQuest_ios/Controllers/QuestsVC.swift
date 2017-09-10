//
//  QuestsVC.swift
//  ReQuest_ios
//
//  Created by Leon Mak on 9/9/17.
//  Copyright © 2017 Leon Mak. All rights reserved.
//

import UIKit

class QuestsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var quests: [Quest] = Faker.instance.getQuests()
    
    @IBOutlet weak var questsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questsTable.dataSource = self
        questsTable.delegate = self
        questsTable.estimatedRowHeight = 90
    }
    
    // MARK: TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.quests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = questsTable.dequeueReusableCell(withIdentifier: Constants.QuestCellId, for: indexPath) as? QuestsCell else {
            return UITableViewCell()
        }
        let quest = quests[indexPath.row]
        cell.configureCell(quest: quest)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = questsTable.cellForRow(at: indexPath) as? QuestsCell {
            performSegue(withIdentifier: Constants.DetailVCId, sender: cell.quest)
        }
    }
    
    // MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.DetailVCId,
            let detailVC = segue.destination as? DetailVC,
            let quest = sender as? Quest {
            detailVC.quest = quest
        }
    }
    
}
