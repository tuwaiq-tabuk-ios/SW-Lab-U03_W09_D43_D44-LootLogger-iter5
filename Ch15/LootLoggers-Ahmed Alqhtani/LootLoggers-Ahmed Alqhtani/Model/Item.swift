//
//  Item.swift
//  LootLoggers
//
//  Created by Ahmed Alqhtani on 12/04/1443 AH.
//

import UIKit

class Item : Equatable, Codable {
  var id:String
  var name: String
  var valueInDollars: Int
  var serialNumber: String?
  var dateCreated: Date
  
  init(name: String, serialNumber: String?, valueInDollars: Int,id:String) {
    self.name = name
    self.valueInDollars = valueInDollars
    self.serialNumber = serialNumber
    self.dateCreated = Date()
    self.id = id
  }
  
  convenience init(random: Bool = false) {
    if random {
      let adjectives = ["Fluffy", "Rusty", "Shiny"]
      let nouns = ["Bear", "Spork", "Mac"]
      let randomAdjective = adjectives.randomElement()!
      let randomNoun = nouns.randomElement()!
      let randomName = "\(randomAdjective) \(randomNoun)"
      let randomValue = Int.random(in: 0..<100)
      let randomSerialNumber =
        UUID().uuidString.components(separatedBy: "-").first!
      let randomID = UUID().uuidString
      self.init(name: randomName,
                serialNumber: randomSerialNumber, valueInDollars: randomValue,id:randomID)
    } else {
      
      self.init(name: "", serialNumber: nil, valueInDollars: 0,id:"")
    }
    
  }
  static func == (lhs: Item, rhs: Item) -> Bool {
    return lhs.name == rhs.name
      && lhs.serialNumber == rhs.serialNumber
      && lhs.valueInDollars == rhs.valueInDollars
      && lhs.dateCreated == rhs.dateCreated
  }
  
}



