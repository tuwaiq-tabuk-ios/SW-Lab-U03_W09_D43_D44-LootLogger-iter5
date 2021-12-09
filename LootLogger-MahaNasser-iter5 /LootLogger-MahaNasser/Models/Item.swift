//
//  Item.swift
//  LootLogger-MahaNasser
//
//  Created by Maha S on 14/11/2021.
//

import UIKit

class Item: Equatable {
  
  
  static func ==(lhs: Item, rhs: Item) -> Bool {
    return lhs.name == rhs.name
  }
  
  var name: String
  var valueInDollars: Int
  var serialNumber: String?
  var dateCreated: Date
  var id: String
  
  
  init(name: String, serialNumber: String?, valueInDollars: Int) {
    self.name = name
    self.valueInDollars = valueInDollars
    self.serialNumber = serialNumber
    self.dateCreated = Date()
    self.id = UUID().uuidString
  }
  
  
  convenience init(random: Bool = false) {
    if random {
      let adjectives = ["Fluffy", "Rusty", "Shiny"]
      let nouns = ["Bear", "Spork", "Mac"]
      let randomAdjective = adjectives.randomElement()!
      let randomNoun = nouns.randomElement()!
      let randomName = "\(randomAdjective) \(randomNoun)"
      let randomValue = Int.random(in: 0..<100)
      let randomSerialNumber = UUID().uuidString.components(separatedBy: "-").first!
      self.init(name: randomName,
                serialNumber: randomSerialNumber, valueInDollars: randomValue)
    } else {
      self.init(name: "", serialNumber: nil, valueInDollars: 0)
    }
  }
  
}
