//
//  DetailViewController.swift
//  LootLogger-ATHEER
//
//  Created by Atheer abdullah on 20/04/1443 AH.
//

import UIKit


class DetailViewController: UIViewController , UITextFieldDelegate {
  
  @IBOutlet weak var nameField: UITextField!
  
  @IBOutlet weak var serialField: UITextField!
  
  @IBOutlet weak var valueField: UITextField!
  
  @IBOutlet weak var dataPicker: UIDatePicker!

  
  @IBOutlet weak var toolbar: UIToolbar!
  
  @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
    
    view.endEditing(true)
  }
  
  
  var item: Item! {
    didSet {
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
  
  override func viewDidLoad() {
      super.viewDidLoad()
      configureDatePicker()
    configureToolbar()
  }
 
  func configureToolbar() {
        let cameraAction = UIAction(title: "Camera",
                                image: UIImage(systemName: "camera")) {
          _ in
          print("Present camera")
    }
    
    let photoLibraryAction = UIAction(title: "Photo Library",image: UIImage(systemName: "photo.on.rectangle")) {
    _ in
    print("Present photo library")
    }
    
  let menu = UIMenu(children: [cameraAction, photoLibraryAction])
      
      let cameraItem = UIBarButtonItem(systemItem: .camera, menu: menu)
          toolbar.items = [cameraItem]
      
    }
  
  
  func configureDatePicker() {
      let action = UIAction { [weak self] _ in
//          self.item.dateCreated = self.dataPicker.date
        if let self = self {
                self.item.dateCreated = self.dataPicker.date
            }
      }
      dataPicker.addAction(action, for: .valueChanged)
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    nameField.text = item.name
    serialField.text = item.serialNumber
    valueField.text =
      numberFormatter.string(from: NSNumber(value: item.valueInDollars))
    dataPicker.date = item.dateCreated
  }
  
  
  override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      // "Save" changes to item
      item.name = nameField.text ?? ""
      item.serialNumber = serialField.text
      if let valueText = valueField.text,
          let value = numberFormatter.number(from: valueText) {
          item.valueInDollars = value.intValue
  } else {
          item.valueInDollars = 0
      }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    return true }
  }
  

  }




  

