//
//  RequestsVC.swift
//  ReQuest_ios
//
//  Created by Leon Mak on 9/9/17.
//  Copyright © 2017 Leon Mak. All rights reserved.
//

import UIKit

class RequestsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var requests: [Quest] = Faker.instance.getRequests()
    
    @IBOutlet weak var requestsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestsTable.dataSource = self
        requestsTable.delegate = self
        requestsTable.estimatedRowHeight = 90
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.requests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = requestsTable.dequeueReusableCell(withIdentifier: Constants.RequestCellId, for: indexPath) as? RequestsCell else {
            return UITableViewCell()
        }
        let quest = requests[indexPath.row]
        cell.configureCell(quest: quest)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = requestsTable.cellForRow(at: indexPath) as? RequestsCell {
            performSegue(withIdentifier: Constants.DetailVCId, sender: cell.quest)
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let accept = UITableViewRowAction(style: .normal, title: "Accept") { (rowAction, indexPath) in
            if let _ = self.requestsTable.cellForRow(at: indexPath) as? RequestsCell {
                self.requests.remove(at: indexPath.row)
            }
            self.requestsTable.reloadData()
        }
        accept.backgroundColor = UIColor.flatLime
        let reject = UITableViewRowAction(style: .destructive, title: "Reject") { (rowAction, indexPath) in
            if let _ = self.requestsTable.cellForRow(at: indexPath) as? RequestsCell {
                self.requests.remove(at: indexPath.row)
            }
            self.requestsTable.reloadData()
        }
        reject.backgroundColor = UIColor.flatRed
        return [accept, reject]
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
