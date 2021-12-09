//
//  DetailViewController.swift
//  LootLogger
//
//  Created by Ressam Al-Thebailah on 20/04/1443 AH.
//

import UIKit
import PhotosUI

class DetailViewController : UIViewController , UITextFieldDelegate ,UINavigationControllerDelegate, UIImagePickerControllerDelegate, PHPickerViewControllerDelegate {
  
  @IBOutlet var nameField: UITextField!
  @IBOutlet var serialNumberField: UITextField!
  @IBOutlet var valueField: UITextField!
  //  @IBOutlet var dateLabel: UILabel!
  @IBOutlet var datePicker: UIDatePicker!
  @IBOutlet var toolbar: UIToolbar!
  @IBOutlet var imageView: UIImageView!
  
  var item:Item!{
    didSet {
      navigationItem.title = item.name
    }
  }
  
  var imageStore: ImageStore!
  
  let numberFormatter:NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 2
    formatter.maximumFractionDigits = 2
    return formatter
  }()
  
  //  let dateFormatter : DateFormatter = {
  //   let formatter = DateFormatter()
  //    formatter.dateStyle = .medium
  //    formatter.timeStyle = .none
  //    return formatter
  //  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureDatePicker()
    configureToolbar()
  }
  
  
  func configureToolbar() {
    let supportsCamera = UIImagePickerController.isSourceTypeAvailable(.camera)
    let cameraAction = UIAction(title: "Camera",
                                image: UIImage(systemName: "camera"), attributes: supportsCamera ? [] : [.hidden]) {
      [weak self]  _ in
      //      print("Present camera")
      self?.presentImagePicker()
    }
    
    let photoLibraryAction = UIAction(title: "Photo Library",image: UIImage(systemName: "photo.on.rectangle")) {
      
      [weak self] _ in
      // print("Present photo library")
      self?.presentPhotoPicker()
      
    }
    
    let menu = UIMenu(children: [cameraAction, photoLibraryAction])
    
    let cameraItem = UIBarButtonItem(systemItem: .camera , menu: menu)
    toolbar.items = [cameraItem]
  }
  
  
  func configureDatePicker() {
    let action = UIAction { [weak self]
      _ in
      if let self = self {
        self.item.dateCreated = self.datePicker.date
      }
//      self.item.dateCreated = self.datePicker.date
    }
    datePicker.addAction(action, for: .valueChanged)
  }
  
  
  func presentImagePicker() {
    let imagePicker = UIImagePickerController()
    imagePicker.sourceType = .camera
    imagePicker.delegate = self
    present(imagePicker, animated: true, completion: nil)
  }
  
  
  deinit {
    print("DetailViewController is being deinitialized")
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    nameField.text = item.name
    serialNumberField.text = item.serialNumber
    //    valueField.text = "\(item.valueInDollars)"
    //    dateLabel.text = "\(item.dateCreated)"
    valueField.text = numberFormatter.string(from: NSNumber(value: item.valueInDollars))
    //    dateLabel.text = dateFormatter.string(from: item.dateCreated)
    datePicker.date = item.dateCreated
    
    let key = item.id
    let imageToDisplay = imageStore.image(forKey: key)
    imageView.image = imageToDisplay
  }
  
  
  override func viewWillDisappear(_ animated: Bool) {
    view.endEditing(true)
    super.viewWillDisappear(animated)
    item.name = nameField.text ?? ""
    item.serialNumber = serialNumberField.text
    
    if let valueText = valueField.text ,
       let value = numberFormatter.number(from: valueText){
      item.valueInDollars = value.intValue
    }else{
      item.valueInDollars = 0
    }
  }
  
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  
  @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
    view.endEditing(true)
  }
  
  
  func imagePickerController(_ picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
    
    dismiss(animated: true, completion: nil)
    
    let image = info[.originalImage] as! UIImage
     imageStore.setImage(image, forKey: item.id)
    
    imageView.image = image
  }
  
  
  func presentPhotoPicker() {
    var configuration = PHPickerConfiguration()
    configuration.selectionLimit = 1
    configuration.filter = .images
    let photoPicker = PHPickerViewController(configuration: configuration)
    photoPicker.delegate = self
    present(photoPicker, animated: true, completion: nil)
  }
  
  
  func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
    dismiss(animated: true, completion: nil)
    if let result = results.first, result.itemProvider.canLoadObject(ofClass: UIImage.self) {
      result.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
        if let image = image as? UIImage {
       self.imageStore.setImage(image, forKey: self.item.id)
          
          DispatchQueue.main.async {
            self.imageView.image = image
          }
        }
      }
    }
  }
}
