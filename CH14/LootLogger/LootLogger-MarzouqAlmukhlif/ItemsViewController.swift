//
//  ItemsViewController.swift
//  LootLogger
//
//  Created by Marzouq Almukhlif on 09/04/1443 AH.
//

import UIKit

class ItemsViewController: UITableViewController {
  
  var itemStore: ItemStore!
  
  required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      navigationItem.leftBarButtonItem = editButtonItem
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
    tableView.rowHeight = UITableView.automaticDimension
//    tableView.rowHeight = 65
    tableView.estimatedRowHeight = 65
    
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      tableView.reloadData()
  }
  
  @IBAction func addNewItem(_ sender: UIBarButtonItem) {

      // Create a new item and add it to the store
      let newItem = itemStore.createItem()
      // Figure out where that item is in the array
      if let index = itemStore.allItems.firstIndex(of: newItem) {
          let indexPath = IndexPath(row: index, section: 0)
          // Insert this new row into the table
          tableView.insertRows(at: [indexPath], with: .automatic)
      }
  }
    
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    switch segue.identifier {
      case "showItem":

        if let row = tableView.indexPathForSelectedRow?.row {
              let item = itemStore.allItems[row]
              let detailViewController
                      = segue.destination as! DetailViewController
              detailViewController.item = item
  }
    default:
          preconditionFailure("Unexpected segue identifier.")
      }
  }
  
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return itemStore.allItems.count
  }
  
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell",
                                                 for: indexPath) as! ItemCell
        
        let item = itemStore.allItems[indexPath.row]

        cell.nameLabel.text = item.name
        cell.serialNumberLabel.text = item.serialNumber
        cell.valueLabel.text = "$\(item.valueInDollars)"
    return cell
    
  }
  
  override func tableView(_ tableView: UITableView,
                          commit editingStyle: UITableViewCell.EditingStyle,
                          forRowAt indexPath: IndexPath) {
      // If the table view is asking to commit a delete command...
      if editingStyle == .delete {
          let item = itemStore.allItems[indexPath.row]
          // Remove the item from the store
          itemStore.removeItem(item)
          // Also remove that row from the table view with an animation
          tableView.deleteRows(at: [indexPath], with: .automatic)
      }
  }
  
  
  override func tableView(_ tableView: UITableView,
                          moveRowAt sourceIndexPath: IndexPath,
     // Update the model
  to destinationIndexPath: IndexPath) {
      itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
  }
  
  
}
