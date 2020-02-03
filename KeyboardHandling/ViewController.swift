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
    
    private var originalYConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerForKeyboardNotifs()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        pulsateLogo()
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
        originalYConstraint = pursuitLogoCenterYConstraint // save original value
        pursuitLogoCenterYConstraint.constant -= height // (height * 0.80)
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        keyboardIsVisible = true
    }
    
    private func resetUI() {
        keyboardIsVisible = false
        //-314 = 0, +314
        //double negative => positive
        pursuitLogoCenterYConstraint.constant -= originalYConstraint.constant
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func pulsateLogo() {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [.repeat, .autoreverse], animations: {
            self.pursuitLogo.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: nil)
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        resetUI()
        return true
    }
    
    
}

