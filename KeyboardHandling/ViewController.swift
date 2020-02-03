//
//  ViewController.swift
//  KeyboardHandling
//
//  Created by Maitree Bain on 2/3/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var pursuitLogo: UIImageView!
    
    @IBOutlet weak var pursuitLogoCenterYConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    private var keyboardIsVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerForKeyboardNotifs()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        unregisteredForKeyboardNotifs()
    }
    
    private func registerForKeyboardNotifs() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func unregisteredForKeyboardNotifs() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        //UIKeyboardFrameEndUserInfoKey
        guard let keyboardFrame = notification.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect else {
            return
        }
        moveKeyboardUp(keyboardFrame.size.height)
    }
    
    @objc private func keyboardWillHide(_ notification: NSNotification) {
        //TODO: complete
    }
    
    
    private func moveKeyboardUp(_ height: CGFloat) {
        
        if keyboardIsVisible { return }
        pursuitLogoCenterYConstraint.constant -= height
        keyboardIsVisible = true
    }
}

