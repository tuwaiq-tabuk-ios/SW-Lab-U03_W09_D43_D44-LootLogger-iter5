//
//  ItemStore .swift
//  Table Rawabi
//
//  Created by روابي باجعفر on 11/04/1443 AH.
//

import Foundation
import UIKit

class itemStore {
  
    var allItems = [item]()

  @discardableResult func createItem() -> item {
      let newItem = item(random: true)
      allItems.append(newItem)
      return newItem
  }
  init() {
      for _ in 0..<5 {
          createItem()
      }
  }
}
