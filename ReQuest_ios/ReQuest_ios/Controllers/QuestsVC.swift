//
//  QuestsVC.swift
//  ReQuest_ios
//
//  Created by Leon Mak on 9/9/17.
//  Copyright © 2017 Leon Mak. All rights reserved.
//

import UIKit

class QuestsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var quests: [Quest] = []
    
    @IBOutlet weak var questsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.quests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = questsTable.dequeueReusableCell(withIdentifier: Constants.RequestCellId, for: indexPath) as? RequestsCell else {
            return UITableViewCell()
        }
        let quest = quests[indexPath.row]
        cell.configureCell(quest: quest)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = questsTable.cellForRow(at: indexPath) as? RequestsCell {
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
