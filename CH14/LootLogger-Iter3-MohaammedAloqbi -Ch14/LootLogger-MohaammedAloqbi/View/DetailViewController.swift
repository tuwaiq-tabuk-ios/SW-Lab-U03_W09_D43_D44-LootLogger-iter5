//
//  DetailViewController.swift
//  LootLogger-MohaammedAloqbi
//
//  Created by Mohammed on 20/04/1443 AH.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var serialNumberField: UITextField!
    @IBOutlet weak var valueField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var toolbar: UIToolbar!
    
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
    
//    let dateFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
//        formatter.timeStyle = .none
//        return formatter
//    }()
//
    
       override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
          
          nameField.text = item.name
          serialNumberField.text = item.serialNumber
      // valueField.text = "\(item.valueInDollars)"
        //replace with this
       valueField.text = numberFormatter.string(from: NSNumber(value: item.valueInDollars))
         // dateLabel.text = "\(item.dateCreated)"
           //replace with this
//        dateLabel.text = dateFormatter.string(from: item.dateCreated )
 
        datePicker.date = item.dateCreated
       
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

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    return true }



    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        
        
        view.endEditing(true)
    
    }
    deinit {
        print("DetailViewController is being deinitialized")
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDatePicker()
        configureToolbar()
    }
    
    
    func configureDatePicker() {
        let action = UIAction { [weak self] _ in
            
            if let self = self {
                    self.item.dateCreated = self.datePicker.date
            
            //self.item.dateCreated = self.datePicker.date
        }
    }
        datePicker.addAction(action, for: .valueChanged)
   
}
    
    func configureToolbar() {
        let cameraAction = UIAction(title: "Camera",
                                    image: UIImage(systemName: "camera")) {
            _ in  print("Present Camera")}
        
        let photoLibraryAction = UIAction(title: "Photo Library",image: UIImage(systemName: "photo.on.rectangle")) {
            _ in print("Present photo library")
        }
        
        let menu = UIMenu(children: [cameraAction, photoLibraryAction])

        let cameraItem = UIBarButtonItem(systemItem: .camera,menu: menu)
        toolbar.items = [cameraItem]
    }
}


