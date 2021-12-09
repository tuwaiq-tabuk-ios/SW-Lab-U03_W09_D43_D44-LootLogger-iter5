//
//  DetailViewController.swift
//  LootLogger
//
//  Created by mona M on 25/11/2021.
//

import UIKit
class DetailViewController: UIViewController {
  
  @IBOutlet weak var nameField: UITextField!
  
  @IBOutlet weak var  serialNumberField: UITextField!
  
  @IBOutlet weak var valueField: UITextField!
  
  @IBOutlet var datePicker: UIDatePicker!

  @IBOutlet var toolbar: UIToolbar!

  
  
  @IBAction func backgroundTapped(_ sender: Any) {
    view.endEditing(true)
  }
  
  
  
  var item: Item!{
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

  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    nameField.text = item.name
    serialNumberField.text = item.serialNumber
    //valueField.text = "\(item.valueInDollars)"
    //dateLabel.text = "\(item.dateCreated)"
    valueField.text =
    numberFormatter.string(from: NSNumber(value: item.valueInDollars))
    datePicker.date = item.dateCreated
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
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
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ChangeDate" {
      let ChangeDateViewController = segue.destination as! ChangeDateViewController
      ChangeDateViewController.item = item
    }
  }
  
  
  func configureDatePicker() {
      let action = UIAction {  [weak self] _ in
        if let self = self {
                self.item.dateCreated = self.datePicker.date
            }
      }
      datePicker.addAction(action, for: .valueChanged)
  }

  deinit {
      print("DetailViewController is being deinitialized")
  }
  
  func configureToolbar() {
      
    let cameraAction = UIAction(title: "Camera",
                                image: UIImage(systemName: "camera")) { _ in print("Present camera")}
    
    let photoLibraryAction = UIAction(title: "Photo Library", image: UIImage(systemName: "photo.on.rectangle")) { _ in print("Present photo library")}
      
    let menu = UIMenu(children: [cameraAction, photoLibraryAction])
      
      
    let cameraItem = UIBarButtonItem(systemItem: .camera , menu: menu)
      toolbar.items = [cameraItem]
  }

}

