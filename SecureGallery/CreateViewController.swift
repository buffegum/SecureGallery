//
//  CreateViewController.swift
//  SecureGallery
//
//  Created by Дмитрий  Ванчугов on 22.02.2022.
//

import UIKit

class CreateViewController: UIViewController {

    @IBOutlet var firstTextField: UITextField!
    @IBOutlet var secondTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        savePassword()
        navigationController?.popViewController(animated: true)
        
    }
    
    func savePassword(){
        if firstTextField.text == secondTextField.text {
            let password = firstTextField.text
            UserDefaults.standard.setValue(password, forKey: "password")
        }
    }

}

extension CreateViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstTextField.resignFirstResponder()
        secondTextField.resignFirstResponder()
        return true
    }
    
    
}
