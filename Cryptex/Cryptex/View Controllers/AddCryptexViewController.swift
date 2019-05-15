//
//  AddCryptexViewController.swift
//  Cryptex
//
//  Created by Michael Stoffer on 5/14/19.
//  Copyright © 2019 Michael Stoffer. All rights reserved.
//

import UIKit

class AddCryptexViewController: UIViewController {
    
    @IBOutlet weak var hintTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var cryptexController: CryptexController?
    
    @IBAction func addCryptexButtonTapped(_ sender: UIButton) {
        guard let hint = self.hintTextField.text,
            let password = self.passwordTextField.text else { return }
        
        self.cryptexController?.createCryptex(withPassword: password, withHint: hint)
        navigationController?.popViewController(animated: true)
    }
}
