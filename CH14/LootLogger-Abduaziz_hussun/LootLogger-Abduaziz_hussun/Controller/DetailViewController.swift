//
//  DetailViewController.swift
//  LootLogger-Abduaziz_hussun
//
//  Created by azooz alhwiti on 25/11/2021.
//

import UIKit

class DetailViewController: UIViewController {
  
 
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
  return true }
  
  

  @IBOutlet weak var nameField: UITextField!
  
  @IBOutlet weak var serialNumberField: UITextField!
  
  
  @IBOutlet weak var valueField: UITextField!
  
  @IBOutlet var toolbar: UIToolbar!
  
  @IBOutlet var datePicker: UIDatePicker!
  
  
  

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
  
//  let dateFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .medium
//    formatter.timeStyle = .none
//    return formatter
//  }()
  
  override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
    nameField.text = item.name
    serialNumberField.text = item.serialNumber
    valueField.text = numberFormatter.string(from: NSNumber(value: item.valueInDollars))
//    dateLabel.text = dateFormatter.string(from: item.dateCreated)
     datePicker.date = item.dateCreated

  }
  override func viewDidLoad() {
      super.viewDidLoad()
      configureDatePicker()
      configureToolbar()
  }
  func configureToolbar(){
      let cameraAction = UIAction(title: "Camera",
                              image: UIImage(systemName: "camera")) {_ in
        print("Present camera")}
  let photoLibraryAction = UIAction(title: "Photo Library",image: UIImage(systemName: "photo.on.rectangle")) {_ in
          print("Present photo library")
      }
      let menu = UIMenu(children: [cameraAction, photoLibraryAction])
  let cameraItem = UIBarButtonItem(systemItem: .camera, menu: menu)
      toolbar.items = [cameraItem]
  }

  func configureDatePicker() {
    
    // self.item.dateCreated = self.datePicker.date if let self = self {
           
    let action = UIAction { [weak self] _ in
        // self.item.dateCreated = self.datePicker.date
      
      if let self = self {
              self.item.dateCreated = self.datePicker.date
          }
    }
    datePicker.addAction(action, for: .valueChanged)
  }
  
    
  override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      // "Save" changes to item
      item.name = nameField.text ?? ""
      item.serialNumber = serialNumberField.text
      if let valueText = valueField.text,
          let value = numberFormatter.number(from: valueText) {
          item.valueInDollars = value.intValue
  } else {
          item.valueInDollars = 0
      }
  }
  
  
  deinit {
      print("DetailViewController is being deinitialized")
  }
  
  
  
  
  
  @IBAction func backgroundTappe(_ sender: UITapGestureRecognizer) {
    // Clear first responder
    view.endEditing(true)
    // "Save" changes to item
       item.name = nameField.text ?? ""
       item.serialNumber = serialNumberField.text
       if let valueText = valueField.text,
           let value = numberFormatter.number(from: valueText) {
           item.valueInDollars = value.intValue
   } else {
           item.valueInDollars = 0
       }
  }
}
