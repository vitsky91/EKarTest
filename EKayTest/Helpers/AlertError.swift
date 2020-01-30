//
//  AlertError.swift
//  EKayTest
//
//  Created by Vitalii Sydorskyi on 1/29/20.
//  Copyright © 2020 Vitalii Sydorskyi. All rights reserved.
//

import Foundation
import UIKit

class AlertError {
    
    static func showErrorAlert() -> UIAlertController {
        
        let alertController = UIAlertController(title: "Error", message: "Something went wrong, please try again", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        
        alertController.addAction(okAction)
        
        return alertController
    }
    
    static func alertToAskCameraAccess() -> UIAlertController {
        let alert = UIAlertController(
            title: "IMPORTANT",
            message: "Camera access required for capturing photos!",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Allow Camera", style: .cancel, handler: { (alert) -> Void in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }))
        
        return alert
    }
    
}
