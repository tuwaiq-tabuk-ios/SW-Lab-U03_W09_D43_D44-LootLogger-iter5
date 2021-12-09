//
//  ItemsViewController.swift
//  LootLoggers
//
//  Created by عبدالعزيز البلوي on 12/04/1443 AH.
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
    //tableView.rowHeight = 65
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 65
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }
  
  @IBAction func Menus(_ sender: UILongPressGestureRecognizer) {
    
  }
  
  @IBAction func addNewItem(_ sender: UIBarButtonItem) {
    let newItem = itemStore.createItem()
    if let index = itemStore.allItems.firstIndex(of: newItem) {
      let indexPath = IndexPath(row: index, section: 0)
      tableView.insertRows(at: [indexPath], with: .automatic)
    }
  }
  
  
  
  override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
      return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in
         let deleteAction = UIAction(title: "Delete", image: UIImage(systemName: "trash.fill"), identifier: nil, discoverabilityTitle: "", attributes: UIMenuElement.Attributes.destructive) { action in
          self.itemStore.removeItem(self.itemStore.allItems[indexPath.row])

              //Remove from the table.
              self.tableView.deleteRows(at: [indexPath], with: .automatic)
          }
        var icon :String
        var title:String
        if self.itemStore.allItems[indexPath.row].isFavorite {
          title = "UnFavorite"
          icon = "heart.slash"
        }else{
          title = "Favorite"
          icon = "suit.heart.fill"
        }
        let favoriteAction = UIAction(title: title, image: UIImage(systemName: icon), identifier: nil, discoverabilityTitle: "") { action in
          let item = self.itemStore.allItems[indexPath.row]
          if item.isFavorite {
            item.isFavorite = false
          }else{
            item.isFavorite = true
          }

             //Remove from the table.
             self.tableView.reloadData()
         }


        return UIMenu(title: "", children: [deleteAction,favoriteAction])
      }
  }
  
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return itemStore.allItems.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    // let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell",for: indexPath)
    let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell",for: indexPath) as! ItemCell
    
    let item = itemStore.allItems[indexPath.row]
    if item.isFavorite{
      cell.nameLabel.text = "\(item.name) (Favorite)"
    }else{
      cell.nameLabel.text = item.name
    }
    
    // cell.textLabel?.text = item.name
    // cell.detailTextLabel?.text = "$\(item.valueInDollars)"
   
    cell.serialNumberLabel.text = item.serialNumber
    cell.valueLabel.text = "$\(item.valueInDollars)"
    return cell
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
  override func tableView(_ tableView: UITableView,
                          moveRowAt sourceIndexPath: IndexPath,
                          to destinationIndexPath: IndexPath) {
    itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
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
  /*
   // Override to support conditional editing of the table view.
   override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the specified item to be editable.
   return true
   }
   */
  
  /*
   // Override to support editing the table view.
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
   if editingStyle == .delete {
   // Delete the row from the data source
   tableView.deleteRows(at: [indexPath], with: .fade)
   } else if editingStyle == .insert {
   // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
   }
   }
   */
  
  /*
   // Override to support rearranging the table view.
   override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
   
   }
   */
  
  /*
   // Override to support conditional rearranging of the table view.
   override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the item to be re-orderable.
   return true
   }
   */
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}
