//
//  DetailViewController.swift
//  LootLogger
//
//  Created by ABRAR ALQARNI on 20/04/1443 AH.
//

import UIKit

class DetailViewController: UIViewController {
  
  @IBOutlet weak var nameField: UITextField!
  @IBOutlet var serialNumberField: UITextField!
  @IBOutlet var valueField: UITextField!
  
  @IBOutlet var datePicker: UIDatePicker!
  @IBOutlet var toolbar: UIToolbar!
  
  
  @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
    
    view.endEditing(true)
  }
  
  var item: Item!{ didSet {
    navigationItem.title
      = item.name
  }
  }
  
  
  let numberFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 2
    formatter.maximumFractionDigits = 2
    return formatter
  }()
  
  
  
  override func viewDidLoad() {
    valueField.keyboardType = .numberPad
    configureDatePicker()
    configureToolbar()
  }
  
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    nameField.text = item.name
    serialNumberField.text = item.serialNumber
    valueField.text =
      numberFormatter.string(from: NSNumber(value: item.valueInDollars))
    datePicker.date = item.dateCreated
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
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
  
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true }
  
  //  MARK: - configureDatePicker
  
  func configureDatePicker() {
    
    let action = UIAction { [weak self] _ in
//      self.item.dateCreated = self.datePicker.date
      if let self = self {
              self.item.dateCreated = self.datePicker.date
          }
    }
    datePicker.addAction(action, for: .valueChanged)
  }
  deinit {
      print("DetailViewController is being deinitialized")
  }
  //  MARK: - configureToolbar
  func configureToolbar() {
    //    Adding the context menu
    let cameraAction = UIAction(title: "Camera",
                                image: UIImage(systemName: "camera")) {
      _ in
          print("Present camera")
    }
    let photoLibraryAction = UIAction(title: "Photo Library",
                                      image: UIImage(systemName: "photo.on.rectangle")) {
      _ in
            print("Present photo library")
        }
    
      let menu = UIMenu(children: [cameraAction, photoLibraryAction])
    
      let cameraItem = UIBarButtonItem(systemItem: .camera, menu: menu)
      toolbar.items = [cameraItem]
    

  }
  
  
}




