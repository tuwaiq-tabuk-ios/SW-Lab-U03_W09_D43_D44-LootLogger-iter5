//
//  ImageStore.swift
//  LootLogger
//
//  Created by apple on 03/05/1443 AH.
//

import UIKit
class ImageStore {
    let cache = NSCache<NSString,UIImage>()
  func setImage(_ image: UIImage, forKey key: String) {
         cache.setObject(image, forKey: key as NSString)
    let url = imageURL(forKey: key)
        do {
            try FileManager.default.removeItem(at: url)
        } catch {
            print("Error removing the image from disk: \(error)")
        }
       // Turn image into JPEG data
       if let data = image.jpegData(compressionQuality: 0.5) {
           // Write it to full URL
           try? data.write(to: url)
       }
    
    
    
    
     }
     func image(forKey key: String) -> UIImage? {
         return cache.object(forKey: key as NSString)
      
     }
     func deleteImage(forKey key: String) {
         cache.removeObject(forKey: key as NSString)
      
     }
  func imageURL(forKey key: String) -> URL {
      let documentsDirectories =
          FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
      let documentDirectory = documentsDirectories.first!
      return documentDirectory.appendingPathComponent(key)
  }
  
}
