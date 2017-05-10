//
//  MasterTableViewController.swift
//  Memo
//
//  Created by Jarvis@Rave on 2017-05-09.
//  Copyright © 2017 Jarvis@Rave. All rights reserved.
//

import UIKit

class MasterTableViewController: UITableViewController {
	
	private var toDoItems: NSMutableArray = NSMutableArray()

	override func viewDidAppear(_ animated: Bool) {
		let userDefaults: UserDefaults = UserDefaults.standard
		
		let itemListFromUserDefaults: NSMutableArray? = userDefaults.object(forKey: "itemList") as? NSMutableArray
		
		if (itemListFromUserDefaults != nil) {
			toDoItems = itemListFromUserDefaults!
		}
		
		self.tableView.reloadData()
	}

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return toDoItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		
		let toDoItem: NSDictionary = toDoItems.object(at: indexPath.row) as! NSDictionary
		cell.textLabel!.text = toDoItem.object(forKey: "itemTitle") as? String
        return cell
    }
 
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if (segue.identifier == "showDetail") {
			let selectedIndexPath: NSIndexPath = self.tableView.indexPathForSelectedRow!as NSIndexPath
			let detailViewController: DetailViewController = segue.destination as! DetailViewController
			detailViewController.toDoData = toDoItems.object(at: selectedIndexPath.row) as! NSDictionary
		}
    }

}
