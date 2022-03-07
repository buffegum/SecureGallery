//
//  ManagerViewController.swift
//  SecureGallery
//
//  Created by Дмитрий  Ванчугов on 22.02.2022.
//

import UIKit

class ManagerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func backButtonPress(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func toGalleryVCButtonPress(_ sender: UIButton) {
        guard let controller = self.storyboard?.instantiateViewController(identifier: "GalleryViewController") as? GalleryViewController else {return}
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func toAddVCButtonPress(_ sender: UIButton) {
        guard let controller = self.storyboard?.instantiateViewController(identifier: "AddViewController") as? AddViewController else {return}
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
