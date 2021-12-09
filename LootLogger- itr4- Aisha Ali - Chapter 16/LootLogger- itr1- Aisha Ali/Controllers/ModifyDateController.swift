  //
//  File.swift
//  LootLogger- itr1- Aisha Ali
//
//  Created by Aisha Ali on 11/25/21.
//

import UIKit

class ModifyDateController : UIViewController {
  
  var item: Item!
  
  @IBOutlet weak var datePicker: UIDatePicker!
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
        datePicker.setDate(item.dateCreated, animated: true)
    
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(true)
    
    item.dateCreated = datePicker.date
    
  }
}
