//
//  Item.swift
//  LootLogger-ATHEER
//
//  Created by Atheer abdullah on 11/04/1443 AH.
//

import UIKit


class Item: Equatable, Codable {
  

  typealias Codable = Decodable & Encodable
  
  static func == (lhs: Item, rhs: Item) -> Bool {
    return lhs.name == rhs.name
      
  && lhs.serialNumber == rhs.serialNumber
  && lhs.valueInDollars == rhs.valueInDollars
  && lhs.dateCreated == rhs.dateCreated
  }
  
  
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
      
      let adjectives = ["Fluffy", "Rusty", "Shiny"]
      let nouns = ["Bear", "Spork", "Mac"]
      
      let randomAdjective = adjectives.randomElement()!
      let randomNoun = nouns.randomElement()!
      
      let randomName = "\(randomAdjective) \(randomNoun)"
      let randomValue = Int.random(in: 0..<100)
      let randomSerialNumber =
      UUID().uuidString.components(separatedBy: "-").first!
      
      self.init(name: randomName,
                serialNumber: randomSerialNumber,
                valueInDollars: randomValue)
    } else {
      self.init(name: "", serialNumber: nil, valueInDollars: 0)
  }
  }
  
}
    protocol Encodable {
        func encode(to encoder: Encoder) throws
    }
    protocol Decodable {
        init(from decoder: Decoder) throws
    }

 


