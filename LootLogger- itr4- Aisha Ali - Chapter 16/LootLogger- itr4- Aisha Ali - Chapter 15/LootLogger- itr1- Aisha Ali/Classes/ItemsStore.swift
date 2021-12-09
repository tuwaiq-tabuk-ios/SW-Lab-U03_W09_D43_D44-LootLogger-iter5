//
//  ItemsStore.swift
//  LootLogger- itr1- Aisha Ali
//
//  Created by Aisha Ali on 11/15/21.
//

import UIKit

class ItemStore {
  
  var allItems = [Item]()
  let itemsArchiveURL:URL = {
    let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentDirectory = documentsDirectories.first!
    return documentDirectory.appendingPathComponent("items.plist")
  }()
  
  
  
  
  
  
  
  
  var label = ItemCell()
  
  
  @discardableResult func createItem() -> Item {
    let newItem = Item(random: true)
    
    allItems.append(newItem)
    
    return newItem
  }
  
  
  func filterItemsBy(_ price: Int = 50) -> [[Item]] {
    var filteredItems = [[Item](), [Item]()]
    for item in allItems {
      
      if item.valueInDollars > price {
        filteredItems[0].append(item)
      } else {
        
        filteredItems[1].append(item)
        
      }
    }
    return filteredItems
  }
  

  
  
  
  func removeItem(_ item: Item) {
    if let index = allItems.firstIndex(of: item) {
      allItems.remove(at: index)
    }
  }
  
  
  func moveItem(from fromIndex: Int, to toIndex: Int) {
    if fromIndex == toIndex {
      return }
    let movedItem = allItems[fromIndex]
    allItems.remove(at: fromIndex)
    allItems.insert(movedItem, at: toIndex)
  }
  
  
  
  @objc func saveChanges()  throws {
    
    print ("Saving items to: \(itemsArchiveURL)")
    do {
      let encoder = PropertyListEncoder()
      //    let data = encoder.encode(allItems)
      let data = try encoder.encode(allItems)
      try data.write(to: itemsArchiveURL, options: [.atomic])
      print("Saved all the items")
    } catch {
      throw RuntimeError.readingDataError("Error reading in saved items: \(error)")

    }
    
  }
  
  init() {
    do{
      let data = try Data(contentsOf: itemsArchiveURL)
      let unaarchiver = PropertyListDecoder()
      let items = try unaarchiver.decode([Item].self, from: data)
      allItems = items
    } catch {
      
      
    }
    for _ in 0..<5 {
      createItem()
    }
    
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(self,  selector: #selector(saveChanges), name: UIScene.didEnterBackgroundNotification,
                                   object: nil)
    
    
    
  }
}


