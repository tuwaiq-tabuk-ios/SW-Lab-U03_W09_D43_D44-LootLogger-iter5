//
//  item.swift
//  prototype-table-Reema.Mousa
//
//  Created by Reema Mousa on 10/04/1443 AH.
//

import UIKit


class Item: Equatable , Codable{
  //
  var name:String
  var valueInDollars: Int
  var serialNumber: String?
  var dateCreated: Date
  
  static func ==(lhs: Item, rhs: Item) -> Bool {
    return lhs.name == rhs.name
    && lhs.serialNumber == rhs.serialNumber
    && lhs.valueInDollars == rhs.valueInDollars
    && lhs.dateCreated == rhs.dateCreated
  }
  
  init(name: String, serialNumber: String?, valueInDollars: Int)
  {
    self.name = name
    self.serialNumber = serialNumber
    self.valueInDollars = valueInDollars
    self.dateCreated = Date()
  }
  
  
  convenience init(random: Bool = false){
    if random  {
      let adjectives = ["Fluffy","Rusty","Snamenamenamenamenamenamenamenamenamenamenamenamenamenamenamenamenamenamenamenamenamenamenamenamehiny"]
      let nouns = ["Bear","Spork","Mac"]
      
      let randomAdjective = adjectives.randomElement()!
      let randomNoun = nouns.randomElement()!
      
      let randomName = "\(randomAdjective) \(randomNoun)"
      let randomValue = Int.random(in: 0..<100)
      //Primery key UUID
      let randomSerialNumber = UUID().uuidString.components(separatedBy: "-").first!
      
      self.init(name:randomName,
                serialNumber:randomSerialNumber,
                valueInDollars:randomValue)
    }else{
      self.init(name: "", serialNumber: nil, valueInDollars: 0)
    }
  }
}
