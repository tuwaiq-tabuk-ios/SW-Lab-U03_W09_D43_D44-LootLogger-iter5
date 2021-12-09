//
//  DetailViewController.swift
//  LootLogger-Ameera-Alhawiti
//
//  Created by Ameera BA on 25/11/2021.
//

import UIKit
import PhotosUI

class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, PHPickerViewControllerDelegate {
  
  
  func picker(_ picker: PHPickerViewController,
              didFinishPicking results: [PHPickerResult]) {
    dismiss(animated: true, completion: nil)
    
    if let result = results.first, result.itemProvider.canLoadObject(ofClass: UIImage.self) {
      result.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
        if let image = image as? UIImage {
          // Store the image in the ImageStore for the item's key
          self.imageStore.setImage(image, forKey: self.item.id)
          
          // Put that image on the screen in the image view
          DispatchQueue.main.async {
            self.imageView.image = image
          }
        }
      }
    }
  }
  
  
  
  @IBOutlet weak var nameField: UITextField!
  @IBOutlet weak var serialNumberField: UITextField!
  @IBOutlet weak var valueField: UITextField!
  @IBOutlet weak var datePicker: UIDatePicker!
  @IBOutlet weak var toolbar: UIToolbar!
  @IBOutlet weak var imageView: UIImageView!
  
  
  @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
    view.endEditing(true)
  }
  
  
  var item: Item!{
    didSet{
      navigationItem.title = item.name
    }
  }
  
  var imageStore: ImageStore!
  
  let numberFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 2
    formatter.maximumFractionDigits = 2
    return formatter
  }()
  
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    nameField.text = item.name
    serialNumberField.text = item.serialNumber
    valueField.text = numberFormatter.string(from: NSNumber(value: item.valueInDollars))
    datePicker.date = item.dateCreated
    
    // Get the item key
    let key = item.id
    // If there is an associated image with the item, display it on the image view
    let imageToDisplay = imageStore.image(forKey: key)
    imageView.image = imageToDisplay
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
  
  
  
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureDatePicker()
    configureToolbar()
  }
  
  
  func configureDatePicker() {
    let action = UIAction { [weak self] _ in
      //          self.item.dateCreated = self.datePicker.date
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
    let supportsCamera = UIImagePickerController.isSourceTypeAvailable(.camera)
    let cameraAction = UIAction(title: "Camera",
                                image: UIImage(systemName: "camera"),
                                attributes: supportsCamera ? [] : [.hidden]) {
      [weak self] _ in self?.presentImagePicker() }
    
    
    let photoLibraryAction = UIAction(title: "Photo Library",
                                      image: UIImage(systemName: "photo.on.rectangle")) {
      [weak self] _ in self?.presentPhotoPicker()}
    
    let menu = UIMenu(children: [cameraAction, photoLibraryAction])
    
    let cameraItem = UIBarButtonItem(systemItem: .camera, menu: menu)
    toolbar.items = [cameraItem]
  }
  
  
  func presentImagePicker() {
    let imagePicker = UIImagePickerController()
    imagePicker.sourceType = .camera
    imagePicker.delegate = self
    present(imagePicker, animated: true, completion: nil)
  }
  
  
  func imagePickerController(_ picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
    // Take image picker off the screen - you must call this dismiss method
    dismiss(animated: true, completion: nil)
    
    // Get picked image from info dictionary
    let image = info[.originalImage] as! UIImage
    
    // Store the image in the ImageStore for the item's key
    imageStore.setImage(image, forKey: item.id)
    
    // Put that image on the screen in the image view
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
  
}
