//
//  ItemsViewController.swift
//  prototype-table-Reema.Mousa
//
//  Created by Reema Mousa on 10/04/1443 AH.
//

import UIKit

class ItemsViewController: UITableViewController {
  
  var itemStore: ItemStore!
  var imageStore: ImageStore!
  
  @IBAction func addNewItem(_ sender: UIBarButtonItem) {
    let newItem = itemStore.createItem()
    if let index = itemStore.allItems.firstIndex(of: newItem){
      let indexPath = IndexPath(row:index,section:0)
      
      tableView.insertRows(at: [indexPath], with: .automatic)
    }
  }
  //silver
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    navigationItem.leftBarButtonItem = editButtonItem
    
    let backBarButtonItem = UIBarButtonItem(title: " back", style: .plain, target: nil, action: nil)
    navigationItem.backBarButtonItem = backBarButtonItem
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()

  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
 
    //  tableView.rowHeight = 65
    
     tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 65
  }
  override func tableView(_ tableView: UITableView,
                          moveRowAt sourceIndexPath: IndexPath,to destinationIndexPath: IndexPath) {
    itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
  }
  override func tableView(_ tableView: UITableView,
                          commit editingStyle: UITableViewCell.EditingStyle,
                          forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let item = itemStore.allItems[indexPath.row]
      itemStore.removeItem(item)
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
  //169
  
  //do
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return itemStore.allItems.count
    
  }
  
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell
    = tableView.dequeueReusableCell(withIdentifier: "ItemCell",
                                    for: indexPath) as! ItemCell
    
    let item = itemStore.allItems[indexPath.row]
    //    cell.nameLabel.trailingAnchor.constraint(equalTo: )
    
    cell.nameLabel.text = item.name
    cell.serialNumberLabel.text = item.serialNumber
    cell.valueLabel.text = "$\(item.valueInDollars)"
    
    
    if item.valueInDollars <= 50 {
      cell.valueLabel.textColor = .green
    }else{
      cell.valueLabel.textColor = .red
      
    }
    
    return cell }
  
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
        detailViewController.imageStore = imageStore
      } default:
      preconditionFailure("Unexpected segue identifier.")
      
      
    }
    
    
  }
  
  
  
  override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
    
    return UIContextMenuConfiguration(identifier: nil, previewProvider: nil)
    { suggestedActions in
      let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash.fill"), identifier: nil, discoverabilityTitle: "", attributes: UIMenuElement.Attributes.destructive)  { action in
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
      }
      let Favoraite = UIAction(title: "Favoraite", image: UIImage(systemName: "heart.fill"), identifier: nil, discoverabilityTitle: "")  { action in
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
      }
      return UIMenu(title: "", children: [Favoraite,delete])
    }
  }
  

}
