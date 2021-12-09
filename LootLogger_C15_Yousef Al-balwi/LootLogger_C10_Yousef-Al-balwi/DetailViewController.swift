//
//  DetailViewController.swift
//  LootLogger_C10_Yousef Al-balwi- silver
//
//  Created by Yousef Albalawi on 20/04/1443 AH.
//


import PhotosUI
import UIKit
class DetailViewController: UIViewController , UINavigationControllerDelegate , UIPrintInteractionControllerDelegate, UIImagePickerControllerDelegate, PHPickerViewControllerDelegate {
 
  
  
  func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
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
  } }
  }
  
  
  

  
  @IBOutlet var nameField: UITextField!
  @IBOutlet var serialNumberField: UITextField!
  @IBOutlet var valueField: UITextField!
  @IBOutlet var datePicker: UIDatePicker!
  @IBOutlet var toolbar: UIToolbar!
  @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
    view.endEditing(true)
  }
  @IBOutlet var imageView: UIImageView!
  
  
  var item: Item! { didSet {
    navigationItem.title = item.name  }
  }
  
  
  var imageStore: ImageStore!
  let numberFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 2
    formatter.maximumFractionDigits = 2
    return formatter
  }()
  
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureDatePicker() 
    configureToolbar()
    
  }
    func presentImagePicker() {
      let imagePicker = UIImagePickerController()
      imagePicker.sourceType = .camera
      imagePicker.delegate = self
      present(imagePicker, animated: true, completion: nil)
    }
    
    
    func presentPhotoPicker() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .images
        let photoPicker = PHPickerViewController(configuration: configuration)
       photoPicker.delegate = self
        present(photoPicker, animated: true, completion: nil)
    }
  
  func configureToolbar() {
    
    let supportsCamera = UIImagePickerController.isSourceTypeAvailable(.camera)
    let cameraAction = UIAction(title: "Camera",
                                image: UIImage(systemName: "camera"), attributes: supportsCamera ? [] : [.hidden]) { [weak self] _ in
      
      self?.presentImagePicker()
      
    }
    let photoLibraryAction = UIAction(title: "Photo Library",
                                      image: UIImage(systemName: "photo.on.rectangle")) {[weak self]  _ in
      self?.presentPhotoPicker() }
    
    let menu = UIMenu(children: [cameraAction, photoLibraryAction])
    let cameraItem = UIBarButtonItem(systemItem: .camera,menu: menu)
    toolbar.items = [cameraItem]
  }
  
  
  
  func imagePickerController(_ picker: UIImagePickerController,
          didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
      // Take image picker off the screen - you must call this dismiss method
      dismiss(animated: true, completion: nil)
      // Get picked image from info dictionary
      let image = info[.originalImage] as! UIImage
      // Put that image on the screen in the image view
    // Store the image in the ImageStore for the item's key
        imageStore.setImage(image, forKey: item.id)
   
    imageView.image = image
  }
  
  func configureDatePicker() {
    let action = UIAction {  [weak self]  _ in
      if let self = self {
        self.item.dateCreated = self.datePicker.date}
    }
    datePicker.addAction(action, for: .valueChanged)
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    nameField.text = item.name
    serialNumberField.text = item.serialNumber
    valueField.text =
      numberFormatter.string(from: NSNumber(value: item.valueInDollars))
    //    dateLabel.text = dateFormatter.string(from: item.dateCreated)
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
  
}

