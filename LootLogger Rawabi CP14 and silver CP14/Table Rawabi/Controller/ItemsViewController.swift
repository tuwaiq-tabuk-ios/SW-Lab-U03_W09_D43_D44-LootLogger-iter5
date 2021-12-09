//
//  ItemsViewController.swift
//  Table Rawabi
//
//  Created by روابي باجعفر on 11/04/1443 AH.
//

import UIKit

class ItemsViewController: UITableViewController {
  
  
  var itemStore: ItemStore!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 65
    navigationItem.backButtonTitle = ""
    
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
  
  
  // MARK: - Table view data source
  
  func isBiggerThan50(value: Int)
  -> Bool{
    if(value > 50){
      return true
    }
    return false
  }
  
  
  func colorOfValue(cell: ItemsCell, bigger50: Bool) ->  Void {
    
    if(bigger50){
      cell.valueLabel.textColor = UIColor.red
    }else{
      cell.valueLabel.textColor = UIColor.green
    }
  }
  
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }
  
  
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    
    return itemStore.allItems.count
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
      } default:
      preconditionFailure("Unexpected segue identifier.")
    }
  }
  
  
  
  
  
  // MARK: - Table view data source
  
  
  
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // Get a new or recycled cell
    let cell = tableView.dequeueReusableCell(withIdentifier: "ItemsCell",
                                             for: indexPath) as! ItemsCell
    // Set the text on the cell with the description of the item
    // that is at the nth index of items, where n = row this cell
    // will appear in on the table view
    let item = itemStore.allItems[indexPath.row]
    
    cell.nameLabel.text = item.name
    cell.serialNumberLabel.text = item.serialNumber
    cell.valueLabel.text = "$\(item.valueInDollars)"
    cell.serialNumberLabel.text = item.serialNumber
    
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

  override func tableView(_ tableView: UITableView,
                            contextMenuConfigurationForRowAt indexPath: IndexPath,
                            point: CGPoint) -> UIContextMenuConfiguration? {
      
      let favorite = UIAction(title: "Favorite",
                              image: UIImage(systemName: "heart.fill")) { _ in }
      
      let delete = UIAction(title: "Delete",
                            image: UIImage(systemName: "trash.fill"),
                            attributes: [.destructive]) { _ in
        // Perform action
      }
      return UIContextMenuConfiguration(identifier: nil,
                                        previewProvider: nil) { _ in
        UIMenu(children: [favorite, delete])
      }
    }
}
