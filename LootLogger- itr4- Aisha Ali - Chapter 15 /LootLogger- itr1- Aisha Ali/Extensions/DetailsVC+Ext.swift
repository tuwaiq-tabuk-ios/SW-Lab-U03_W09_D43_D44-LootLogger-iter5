//
//  DetailsVC+Ext.swift
//  LootLogger- itr1- Aisha Ali
//
//  Created by Aisha Ali on 12/6/21.
//

import UIKit
import PhotosUI



extension DetailViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate, PHPickerViewControllerDelegate {
  
  
  
  
  func presentImagePicker(){
    
    let imagePicker = UIImagePickerController()
    imagePicker.sourceType = .camera
    imagePicker.delegate = self
    present(imagePicker, animated: true, completion: nil)
  }
  
  
  func imagePickerController(_ Picker:UIImagePickerController,
                             didFinishPickingMediaWithInfo info:
                             [UIImagePickerController.InfoKey:Any]){
    
    dismiss(animated: true, completion: nil)
    
    let image = info[.originalImage] as! UIImage
    imageStore.setImage(image, forKey: item.id)
    imageView.image = image
  }
  
  
  func presentPhotoPicker(){
    
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
          self.imageStore.setImage(image, forKey: self.item.id);          DispatchQueue.main.async {
            self.imageView.image = image
          }
        }
      }
      
    }
  }

}
