//
//  ItemsViewController.swift
//  LootLogger
//
//  Created by Ressam Al-Thebailah on 09/04/1443 AH.
//

import UIKit

class ItemsViewController : UITableViewController {
  
  var itemStore: ItemStore!
  var imageStore: ImageStore!

  @IBAction func addNewItem(_ sender: UIBarButtonItem) {
    
    // Create a new item and add it to the store
    let newItem = itemStore.createItem()
    // Figure out where that item is in the array
    
    if let index = itemStore.allItems.firstIndex(of: newItem)
    {
      let indexPath = IndexPath(row: index, section: 0)
      // Insert this new row into the table
      tableView.insertRows(at: [indexPath], with: .automatic)
    }
  }
  

  required init?(coder aDecorder: NSCoder) {
    super.init(coder: aDecorder)
    navigationItem.leftBarButtonItem = editButtonItem
  }
  
  
  override func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
    return itemStore.allItems.count
  }
  
  
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    // Create an instance of UITableViewCell with default appearance
    let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell",
                                             for: indexPath) as! ItemCell
    
    // Set the text on the cell with the description of the item
    // that is at the nth index of items, where n = row this cell
    // will appear in on the table view
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
        imageStore.deleteImage(forKey: item.id)
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
  
  
  override func viewDidLoad() {
      super.viewDidLoad()
    
    tableView.rowHeight = UITableView.automaticDimension
       tableView.estimatedRowHeight = 65
    
    }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "showItem":
      if let row = tableView.indexPathForSelectedRow?.row{
        
        let item = itemStore.allItems[row]
        let detailViewController = segue.destination as! DetailViewController
        detailViewController.item = item
        detailViewController.imageStore = imageStore
      }
    default:
      preconditionFailure("Unexpected segue identifier")
    }
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    tableView.reloadData()
  }
}
