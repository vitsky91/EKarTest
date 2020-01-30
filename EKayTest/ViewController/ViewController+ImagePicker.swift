//
//  ViewController+ImagePicker.swift
//  EKayTest
//
//  Created by Vitalii Sydorskyi on 1/29/20.
//  Copyright © 2020 Vitalii Sydorskyi. All rights reserved.
//

import Foundation
import UIKit
import AVKit

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func showPhotoPickAlert() {
        
        let alertController = UIAlertController(title: "Choose action", message: "Please choose what you want to do", preferredStyle: .alert)
        
        let camera = UIAlertAction(title: "Take a photo", style: .default) { (_) in
            self.checkCamera()
        }
        
        let imageLibrary = UIAlertAction(title: "Choose photo", style: .default) { (_) in
            self.showPhotoLibrary()
        }
        
        let deletePhoto = UIAlertAction(title: "Delete picked photo", style: .destructive, handler: { (_) in
            self.deletePhoto()
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(camera)
        alertController.addAction(imageLibrary)
        
        if let cell = collectionView.cellForItem(at: lastSelectedIndexPath) as? CustomCollectionViewCell, cell.isImageSetted {
            
            alertController.addAction(deletePhoto)
        }
        
        alertController.addAction(cancel)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func showPhotoLibrary() {
        
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = .photoLibrary
        image.allowsEditing = false
        present(image, animated: true, completion: nil)
    }
    
    func showCamera() {
        
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = .camera
        image.allowsEditing = false
        present(image, animated: true, completion: nil)
    }
    
    func deletePhoto() {
        
        if let cell = collectionView.cellForItem(at: lastSelectedIndexPath) as? CustomCollectionViewCell {
            
            cell.imageView.image = dummyImage
            cell.isImageSetted = false
        }
    }
    
    func checkCamera() {
        
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        
        switch authStatus {
        case .authorized:
            showCamera()
        case .denied:
            present(AlertError.alertToAskCameraAccess(), animated: true)
        default:
            break
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else {
            
            picker.dismiss(animated: true)
            present(AlertError.showErrorAlert(), animated: true)
            
            return
        }
        
        if let cell = self.collectionView.cellForItem(at: self.lastSelectedIndexPath) as? CustomCollectionViewCell {
            
            cell.imageView.image = image
            cell.isImageSetted = true
        }
        
        picker.dismiss(animated: true)
    }
    
}
