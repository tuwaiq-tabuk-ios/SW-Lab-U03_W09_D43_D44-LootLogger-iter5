//
//  ViewController.swift
//  LootLogger-ATHEER
//
//  Created by Atheer abdullah on 11/04/1443 AH.
//

import UIKit

class ItemsViewController: UITableViewController {
  
  var itemStore: ItemStore!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 65
  }
  
  
  @IBAction func addNewItem(_ sender: UIBarButtonItem) {
    
    let newItem = itemStore.createItem()
    
    
    if let index = itemStore.allItems.firstIndex(of: newItem) {
      let indexPath = IndexPath(row: index, section: 0)
      
      tableView.insertRows(at: [indexPath], with: .automatic)
    }
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    navigationItem.leftBarButtonItem = editButtonItem
  }
  
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemStore.allItems.count
  }
  
  
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
    
    
    let item = itemStore.allItems[indexPath.row]
    
    cell.namelabel?.text = item.name
    cell.serialNumberLabel.text = item.serialNumber
    cell.valueinDollersLabel.text =
      "$\(item.valueInDollars)"
    
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
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // If the triggered segue is the "showItem" segue
    switch segue.identifier {
    case "showItem":
      // Figure out which row was just tapped
      if let row = tableView.indexPathForSelectedRow?.row {
        // Get the item associated with this row and pass it along
        let item = itemStore.allItems[row]
        let detailViewController
          = segue.destination as! DetailViewController
        detailViewController.item = item
      } default: preconditionFailure("Unexpected segue identifier.")
    }
  }
  
  
  override func tableView(_ tableView: UITableView,
                          moveRowAt sourceIndexPath: IndexPath,
                          // Update the model
                          to destinationIndexPath: IndexPath) {
    itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }
}
