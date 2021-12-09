

import UIKit
class ItemsViewController: UITableViewController {
  
  var itemStore: ItemStore!
  var imageStore: ImageStore!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 65
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }
  
  @IBAction func addNewItem(_ sender: UIBarButtonItem) {
    
    let newItem = itemStore.createItem()
    if let index = itemStore.allItems.firstIndex(of: newItem) {
      let indexPath = IndexPath(row: index,
                                section: 0)
      
      tableView.insertRows(at: [indexPath],
                           with: .automatic)
    }
  }
  
  
  
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    navigationItem.leftBarButtonItem = editButtonItem
  }
  
  override func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
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
    
    // MARK: - Bronze Challenge: Cell Colors
    item.valueInDollars >= 50 ? (cell.valueLabel.textColor = .red) : (cell.valueLabel.textColor = .green)
    
    return cell
    
  }
  
  
  override func tableView(_ tableView: UITableView,
                          moveRowAt sourceIndexPath: IndexPath,
                          
                          to destinationIndexPath: IndexPath) {
    itemStore.moveItem(from: sourceIndexPath.row,
                       to: destinationIndexPath.row)
  }
  
  
  override func tableView(_ tableView: UITableView,
                          commit editingStyle: UITableViewCell.EditingStyle,
                          forRowAt indexPath: IndexPath) {
    
    if editingStyle == .delete {
      let item = itemStore.allItems[indexPath.row]
      itemStore.removeItem(item)
      imageStore.deleteImage(forKey: item.id)
      tableView.deleteRows(at: [indexPath],
                           with: .automatic)
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
        detailViewController.imageStore = imageStore
      } default:
      preconditionFailure("Unexpected segue identifier.")
    }
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true }
  
  
}
