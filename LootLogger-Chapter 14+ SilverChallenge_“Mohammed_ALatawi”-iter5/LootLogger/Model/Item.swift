//
//  Item.swift
//  LootLogger
//
//  Created by محمد العطوي on 12/04/1443 AH.
//

import UIKit

class Item : Equatable, Codable {
  
  var name: String
  var valueInDollars: Int
  var serialNumber: String?
  var dateCreated: Date
  var isFaborite: Bool
  
  init(name: String,
       serialNumber: String?,
       valueInDollars: Int , isFaborite: Bool) {
    self.name = name
    self.valueInDollars = valueInDollars
    self.serialNumber = serialNumber
    self.dateCreated = Date()
    self.isFaborite = isFaborite
  }
  
  
  convenience init(random: Bool = false) {
    if random {
      let adjectives = ["Fluffy", "Rusty", "Shiny"]
      let nouns = ["Bear", "Spork", "Mac"]
      let randomAdjective = adjectives.randomElement()!
      let randomNoun = nouns.randomElement()!
      let randomName = "\(randomAdjective) \(randomNoun)\(randomAdjective) \(randomNoun)\(randomAdjective) \(randomNoun)"
      let randomValue = Int.random(in: 0..<100)
      let randomSerialNumber =
        UUID().uuidString.components(separatedBy: "-").first!
      
      self.init(name: randomName,
                serialNumber: randomSerialNumber,
                valueInDollars: randomValue, isFaborite:Bool.random())
    } else {
      
      self.init(name: "",
                serialNumber: nil,
                valueInDollars: 0, isFaborite:false)
    }
    
    
  }
  
  static func == (lhs: Item, rhs: Item) -> Bool {
    return lhs.name == rhs.name
      && lhs.serialNumber == rhs.serialNumber
      && lhs.valueInDollars == rhs.valueInDollars
      && lhs.dateCreated == rhs.dateCreated
  }
  
}

