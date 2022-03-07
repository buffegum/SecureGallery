//
//  ViewController.swift
//  SecureGallery
//
//  Created by Дмитрий  Ванчугов on 22.02.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func loginButtonPress(_ sender: UIButton) {
        if checkPassword(){
        guard let controller = self.storyboard?.instantiateViewController(identifier: "ManagerViewController") as? ManagerViewController else {return}
        self.navigationController?.pushViewController(controller, animated: true)
        }
            }
    
    @IBAction func toCreateVCButtonPress(_ sender: UIButton) {
        guard let controller = self.storyboard?.instantiateViewController(identifier: "CreateViewController") as? CreateViewController else {return}
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func checkPassword()->Bool{
        guard let password = UserDefaults.standard.value(forKey: "password") as? String else{return false}
        if password == textField.text {
            return true
        }
        return false
    }
}

extension LoginViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}
