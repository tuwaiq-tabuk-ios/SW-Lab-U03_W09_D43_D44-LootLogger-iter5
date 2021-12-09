//
//  TableVC.swift
//  LootLogger- itr1- Aisha Ali
//
//  Created by Aisha Ali on 11/14/21.
//

import UIKit

class ItemsViewController: UITableViewController {
  
  var filteredItems = [[Item]]()
  
  var itemStore: ItemStore!
  
  let moreThan50Section = 0
  let otherSection = 1
  
  var morethan50Empty: Bool {
    get { return itemStore.allItems.filter{getSectionOf(item: $0) == moreThan50Section}.count == 0 }
  }
  
  var otherSectionsEmpty: Bool {
    get { return itemStore.allItems.filter{getSectionOf(item: $0) == otherSection}.count == 0 }
  }
  
  //MARK: - add New Item
  @IBAction func addNewItem(_ sender: UIButton) {
    
    let moreThan50 = morethan50Empty
    
    let otherSections = otherSectionsEmpty
    
    let newItem = itemStore.createItem()
    
    let section = getSectionOf(item: newItem)
    
    if (section == moreThan50Section && moreThan50) ||
        (section == otherSection && otherSections) {
      tableView.reloadData()
      return
    }
    
    if let index = itemStore.allItems.filter({ getSectionOf(item: $0) == section }).firstIndex(of: newItem) {
      
      let indexPath = IndexPath(row: index, section: section)
      tableView.insertRows(at: [indexPath], with: .automatic)
    }
  }
  
  
  //  @IBAction func toggleEditingMode(_ sender: UIButton) {
  //
  //    if isEditing {
  //
  //      sender.setTitle("Edit", for: .normal)
  //      setEditing(false, animated: true)
  //
  //    } else {
  //
  //      sender.setTitle("Done", for: .normal)
  //      setEditing(true, animated: true)
  //    }
  //  }
  
  //MARK: - ViewDidLoad
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 65
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }
  
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch section {
    case 0:
      return "Over $50"
    case 1:
      return "Under $50"
    default:
      return nil
    }
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    
    return 2
  }
  
  
  func getSectionOf(item :Item) -> Int {
    
    return item.valueInDollars > 50 ? moreThan50Section : otherSection
  }
  
  
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if (section == moreThan50Section && morethan50Empty) ||
        (section == otherSection && otherSectionsEmpty) {
      return 1
    } else {
      
      let moreThan50SectionCount = itemStore.allItems.filter { getSectionOf(item: $0) == moreThan50Section } .count
      
      if section == moreThan50Section {
        
        return moreThan50SectionCount
      } else {
        
        return itemStore.allItems.count - moreThan50SectionCount
      }
    }
  }
  
  //MARK: - Adding sorted items
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell",
                                             for: indexPath) as! ItemCell
    
    let item = itemStore.allItems.filter{ getSectionOf(item: $0) == indexPath.section } [indexPath.row]
    
    
    cell.nameLabel.text = item.name
    cell.serialNumberLabel.text = item.serialNumber
    
    
    if item.valueInDollars >= 50 {
      
      cell.valueLabel.textColor = .red
      
    } else {
      
      cell.valueLabel.textColor = .green
    }
    
    cell.valueLabel.text = "$\(item.valueInDollars)"
    
    return cell
  }
  
  
  //MARK: - Delete Rows
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
    if editingStyle == .delete {
      let item = itemStore.allItems[indexPath.row]
      itemStore.removeItem(item)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }
  
  
  override func tableView(_ tableView: UITableView,moveRowAt sourceIndexPath: IndexPath,to destinationIndexPath: IndexPath) {
    
    itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    switch segue.identifier {
    case "showItem":
      
      if let row = tableView.indexPathForSelectedRow?.row {
        
        let item = itemStore.allItems[row]
        let detailViewController = segue.destination as! DetailViewController
        detailViewController.item = item
      }
    default:
      preconditionFailure("Unexpected segue identifier.")
    }
  }
  
  
  //MARK Silver solved Here Challenge here
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    navigationItem.leftBarButtonItem = editButtonItem
    navigationItem.backButtonTitle = "Log"
  }
  
  
}










