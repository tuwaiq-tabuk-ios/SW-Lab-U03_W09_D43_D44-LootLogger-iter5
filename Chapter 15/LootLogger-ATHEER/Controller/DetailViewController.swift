//
//  DetailViewController.swift
//  LootLogger-ATHEER
//
//  Created by Atheer abdullah on 20/04/1443 AH.
//

import UIKit
import PhotosUI


class DetailViewController: UIViewController , UITextFieldDelegate, UINavigationControllerDelegate , UIImagePickerControllerDelegate, PHPickerViewControllerDelegate {
  
  
  
  @IBOutlet weak var nameField: UITextField!
  
  @IBOutlet weak var serialField: UITextField!
  
  @IBOutlet weak var valueField: UITextField!
  
  @IBOutlet weak var dataPicker: UIDatePicker!
  
  @IBOutlet weak var imageView: UIImageView!
  
  @IBOutlet weak var toolbar: UIToolbar!
  
  @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
    
    view.endEditing(true)
  }
  
  
  var item: Item! {
    didSet {
      navigationItem.title = item.name
    }
  }
  var imageStore : ImageStore!
  
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
    
    let supportsCamera = UIImagePickerController.isSourceTypeAvailable(.camera)
    let cameraAction = UIAction(title: "Camera",
                                image: UIImage(systemName: "camera"),
                                attributes: supportsCamera ? [] : [.hidden]){
      [weak self]_ in
      self?.presenImagePicker()
      
    }
    
    let photoLibraryAction = UIAction(title: "Photo Library",image: UIImage(systemName: "photo.on.rectangle")) {
      [weak self]_ in
      self?.presentPhotoPicker()
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
    
    let key = item.id
    let imageToDisplay = imageStore.image(forKey: key)
    imageView.image = imageToDisplay
    
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
  func presenImagePicker() {
    let imagePicker = UIImagePickerController()
    imagePicker.sourceType = .camera
    imagePicker.delegate = self
    present(imagePicker, animated: true, completion: nil)
  }
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
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
          self.imageStore.setImage(image , forKey: self.item.id)
          DispatchQueue.main.async {
            self.imageView.image = image 
          }
        }
        
      }
    }
  }
  
  
  
}






