
import UIKit

class HomeTableViewController: UITableViewController, AddItemDelegate {
    
    var itemListManager: ItemListManager = ItemListManager()
    
    var itemListFromManager: [SingleItem] = [SingleItem]()

    // * Update the table view * //

    override func viewDidAppear(_ animated: Bool) {
        // itemListManager.updateItemList()
        itemListFromManager = itemListManager.itemList
        self.tableView.reloadData()
    }

    // * MARK: - Table view data source * //

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemListFromManager.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item: SingleItem = itemListFromManager[indexPath.row]
        cell.textLabel!.text = item.itemTitle
        return cell
    }

    // * Prepare for the segue "showDetail" and "addItem" * //

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showDetail") {
            let selectedIndexPath: IndexPath = self.tableView.indexPathForSelectedRow! as IndexPath
            let itemDetailViewController: ItemDetailViewController = segue.destination as! ItemDetailViewController
            itemDetailViewController.loadExistedItem(item: itemListFromManager[selectedIndexPath.row], index: selectedIndexPath.row)
            itemDetailViewController.itemListManager = itemListManager
        } else if (segue.identifier == "addItem") {
            let itemDetailViewController: ItemDetailViewController = segue.destination as! ItemDetailViewController
            itemDetailViewController.delegate = self
            itemDetailViewController.itemListManager = itemListManager
            itemDetailViewController.currentItemIndex = nil
            itemDetailViewController.deleteItemButton.isEnabled = false
            itemDetailViewController.addItemButton.isEnabled = false
        }
    }
    
    func userDidAddItem(manager: ItemListManager) {
        itemListManager = manager
    }

}
