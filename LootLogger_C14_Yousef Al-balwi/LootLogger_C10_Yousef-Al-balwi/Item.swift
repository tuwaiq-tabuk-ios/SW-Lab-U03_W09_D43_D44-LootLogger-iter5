//
//  Item.swift
//  LootLogger
//
//  Created by Yousef Albalawi on 11/04/1443 AH.
//
import UIKit
class Item : Equatable, Codable {
  
  
  
  
  var name: String
  var valueInDollars: Int
  var serialNumber: String?
  var dateCreated: Date
  
  init(name: String, serialNumber: String?, valueInDollars: Int) {
    self.name = name
    self.valueInDollars = valueInDollars
    self.serialNumber = serialNumber
    self.dateCreated = Date()
    
    
  }
  
  
  convenience init(random: Bool = false) {
    if random {
      
      let adjectives = ["A gentleman more than twenty years old",
                        "Echo is more than forty years old",
                        "Shiny, very clean use .  .  ."]
      let nouns = ["Bear",
                   "Spork",
                   "Mac Moodel 2017"]
      
      let randomAdjective = adjectives.randomElement()!
      let randomNoun = nouns.randomElement()!
      let randomName = "\(randomAdjective) \(randomNoun)"
      let randomValue = Int.random(in: 0..<100)
      let randomSerialNumber =
        UUID().uuidString.components(separatedBy: "-").first!
      self.init(name: randomName,
                serialNumber: randomSerialNumber, valueInDollars: randomValue)
    } else {
      
      self.init(name: "", serialNumber: nil, valueInDollars: 0)
    }
    
  }
  
  static func == (lhs: Item, rhs: Item) -> Bool {
    return lhs.name == rhs.name
      && lhs.serialNumber == rhs.serialNumber
      && lhs.valueInDollars == rhs.valueInDollars
      && lhs.dateCreated == rhs.dateCreated
 
  }
//  
//  
//  override func viewWillDisappear(_ animated: Bool) {
//      super.viewWillDisappear(animated)
//      // "Save" changes to item
//      item.name = nameField.text ?? ""
//      item.serialNumber = serialNumberField.text
//      if let valueText = valueField.text,
//          let value = numberFormatter.number(from: valueText) {
//          item.valueInDollars = value.intValue
//  } else {
//          item.valueInDollars = 0
//      }
//  }
//
//  
}
