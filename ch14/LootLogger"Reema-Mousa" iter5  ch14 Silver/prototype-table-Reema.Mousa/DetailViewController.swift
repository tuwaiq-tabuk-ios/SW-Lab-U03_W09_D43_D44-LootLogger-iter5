//
//  DetailViewController.swift
//  prototype-table-Reema.Mousa
//
//  Created by Reema Mousa on 20/04/1443 AH.
//

import UIKit
class DetailViewController: UIViewController , UITextFieldDelegate{
  
  var item: Item! { didSet {
    navigationItem.title = item.name
  }
  }
  
  
  @IBOutlet weak var toolbar: UIToolbar!
  
  @IBOutlet var nameField: UITextField!
  
  @IBOutlet var serialNumberField: UITextField!
  
  @IBOutlet var valueField: UITextField!
  
  @IBOutlet weak var datePicker: UIDatePicker!
  
//  @IBOutlet var dateLabel: UILabel!
  
  @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
    view.endEditing(true)
  }
  
  override func viewDidLoad() {
  
      super.viewDidLoad()
      configureDatePicker()
    configureToolbar()

  }
  
  func configureToolbar() {
    
    let cameraAction = UIAction(title: "camera", image: UIImage(systemName: "camera")){
      _ in
      print("present camera")
    }
      let photoLibraryAction = UIAction(title: "Photo Library", image: UIImage(systemName: "photo.on.rectangle"))
    {
      _ in
      print("present photo Library")
      
    }
    let menu = UIMenu(children : [cameraAction , photoLibraryAction])

      let cameraItem = UIBarButtonItem(systemItem: .camera , menu: menu)
      toolbar.items = [cameraItem]
  }
  
  
  func configureDatePicker() {
  let action = UIAction {[ weak self ] _ in
    if let self = self {
      self.item.dateCreated = self.datePicker.date
    }
//  self.item.dateCreated = self.datePicker.date

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
    //  valueField.text = "\(item.valueInDollars)"
    //  dateLabel.text = "\(item.dateCreated)"
    valueField.text = numberFormatter.string(from: NSNumber(value: item.valueInDollars))
//    dateLabel.text = dateFormatter.string(from: item.dateCreated)
    datePicker.date = item.dateCreated
  }
  deinit {
      print("DetailViewController is being deinitialized")
  }
  
 
  
  
}
