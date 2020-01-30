//
//  ViewController.swift
//  EKayTest
//
//  Created by Vitalii Sydorskyi on 1/29/20.
//  Copyright © 2020 Vitalii Sydorskyi. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var commentTextView: UITextView!
    
    var lastSelectedIndexPath: IndexPath!
    
    let cellsTextArray = ["Front Side", "Back Side", "Left Side", "Right Side"]
    let dummyImage = UIImage(named: "No-image-found")
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        registerCollectionCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        subscribeOnKeyboardEvents()
        addGestureToHideKeyboard()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        unsubscribeOnKeyboardEvents()
    }
    
    // MARK: - Private methods
    fileprivate func setupUI() {
        
        commentTextView.layer.borderWidth = 1.0
        collectionView.layer.borderWidth = 1.0
        collectionView.isScrollEnabled = false
    }
    
    fileprivate func addGestureToHideKeyboard() {
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    fileprivate func registerCollectionCells() {
        
        collectionView.register(CustomCollectionViewCell.nib(), forCellWithReuseIdentifier: CustomCollectionViewCell.reuseIdentifier())
    }
    
    fileprivate func checkFilledImages() {
        var shouldHighlightCollectionView = false
        
        collectionView.indexPathsForVisibleItems.forEach { (indexPath) in
            
            if let cell = collectionView.cellForItem(at: indexPath) as? CustomCollectionViewCell {
                
                if cell.isImageSetted == false {
                    
                    shouldHighlightCollectionView = true
                }
            }
        }
        
        collectionView.layer.borderColor = shouldHighlightCollectionView ? UIColor.red.cgColor : UIColor.black.cgColor
    }
    
    // MARK: - Actions
    
    @IBAction func nextButtonTapped() {
        
        checkFilledImages()
        
        //Check for unfilled comment
        commentTextView.layer.borderColor = commentTextView.text.isEmpty ? UIColor.red.cgColor : UIColor.black.cgColor
    }
}


// MARK: - Keyboard handler
extension ViewController {
    
    fileprivate func subscribeOnKeyboardEvents() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    fileprivate func unsubscribeOnKeyboardEvents() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
        //We should take size of keyboard
        let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        //We move view upper depent on keyboard size to show entered text
        self.view.frame.origin.y = -keyboardFrame.height
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        
        //We should take size of keyboard
        let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        //We move view lower depent on keyboard size to show full frame
        self.view.frame.origin.y += keyboardFrame.height
    }
}

