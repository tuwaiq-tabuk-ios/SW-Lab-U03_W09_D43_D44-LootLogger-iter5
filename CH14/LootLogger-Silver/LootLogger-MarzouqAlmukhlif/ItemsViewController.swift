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
  
  
  @IBAction func tapLongPressed(_ sender: UILongPressGestureRecognizer) {
    
    
  }
  override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
    
    return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in
      let deleteAction = UIAction(title: "Delete", image: UIImage(systemName: "trash.fill"), identifier: nil, discoverabilityTitle: "", attributes: UIMenuElement.Attributes.destructive) { action in
        self.itemStore.removeItem(self.itemStore.allItems[indexPath.row])
        
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        
      }
      
      var title = ""
      var icon = ""
      if self.itemStore.allItems[indexPath.row].isFavorite {
        title = "UnFavorite"
        icon = "heart"
      } else {
        title = "Favorite"
        icon = "heart.fill"
      }
      
      let favoriteAction = UIAction(title: title, image: UIImage(systemName: icon), identifier: nil, discoverabilityTitle: "") { action in
        
        var item = self.itemStore.allItems[indexPath.row]
        if item.isFavorite {
          item.isFavorite = false
        } else {
          item.isFavorite = true
        }
        
        self.tableView.reloadData()
        
      }
      
      return UIMenu(title: "", children: [deleteAction,favoriteAction])
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
    if item.isFavorite {
      cell.nameLabel.text = "\(item.name) (Favorite)"
    } else {
      cell.nameLabel.text = item.name
    }
       
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
