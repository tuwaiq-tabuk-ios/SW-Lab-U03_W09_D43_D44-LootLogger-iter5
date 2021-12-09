//
//  ItemCell.swift
//  LootLogger-Ameera-Alhawiti
//
//  Created by Ameera BA on 22/11/2021.
//

import UIKit

class ItemCell: UITableViewCell{
  
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var serialNumberLabel: UILabel!
  @IBOutlet weak var valueLabel: UILabel!
  
  
  //  MARK: -cell colors
    func isMoreThan50(value:Int)->Bool{
      if value > 50{
        return true
      }
      return false
    }
  
}
