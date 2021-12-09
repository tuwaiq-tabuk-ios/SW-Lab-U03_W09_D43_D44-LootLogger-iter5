//
//  SecondView .swift
//  LootLogger- itr1- Aisha Ali
//
//  Created by Aisha Ali on 11/25/21.
//

import Foundation
import UIKit
class DetailViewController:UIViewController{
  
  var item: Item! { didSet {
    navigationItem.title = item.name
  }
  }
  
  let numberFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 2
    formatter.maximumFractionDigits = 2
    return formatter
  }()
  
  let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureDatePicker()
    configureToolbar()
  }
  
  
  
  
  @IBOutlet weak var nameField: UITextField!
  @IBOutlet weak var serialNumberField: UITextField!
  @IBOutlet weak var valueField: UITextField!
  @IBOutlet weak var datePicker: UIDatePicker!
  @IBOutlet weak var toolBar: UIToolbar!
  
  
  
  
  
  @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
    
    view.endEditing(true)
    
  }
  
  
  
  //MARK: - This for segue betwen Detail Scene and Date Secreen
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    switch segue.identifier {
    case "editDate":
      let editDateController = segue.destination as! ModifyDateController
      editDateController.item = item
    default:
      preconditionFailure("Unexpected Segue identifier")
    }
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    nameField.text = item.name
    serialNumberField.text = item.serialNumber
    
    valueField.text = numberFormatter.string(
      from: NSNumber(value: item.valueInDollars))
    datePicker.date = item.dateCreated
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true }
  
  
  
  override func viewWillDisappear(_ animated: Bool) {
    
    super.viewWillDisappear(animated)
    
    //    view.endEditing(true)
    item.name = nameField.text ?? ""
    item.serialNumber = serialNumberField.text
    if let valueText = valueField.text,
       let value = numberFormatter.number(from: valueText) {
      item.valueInDollars = value.intValue
    } else {
      item.valueInDollars = 0
    }
  }
  
  func configureDatePicker (){
    
    let action = UIAction { [weak self] _ in
//      self.item.dateCreated = self.datePicker.date
      if let self = self {
        self.item.dateCreated = self.datePicker.date
      }
    }
    datePicker.addAction(action, for: .valueChanged)
  }
  
  func configureToolbar(){
    let cameraAction = UIAction (title:"Camera", image: UIImage(systemName: "camera")){
      _ in
      print("Present Camera")
    }
    
    let photoLibraryAction = UIAction(title:"Photo Library", image: UIImage(systemName: "photo.on.rectangle")){
      _ in
      print("Present photo Library")
      
    }
    let menu = UIMenu(children: [cameraAction, photoLibraryAction])
    
    let cameraItem = UIBarButtonItem(systemItem: . camera, menu: menu)
    toolBar.items = [cameraItem]
    
  }
  
  
  
  
  deinit {
    print("DetailsViewController is being deinitialized")
  }
  
  
  
  
  
  
}
