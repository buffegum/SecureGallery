//
//  AddViewController.swift
//  SecureGallery
//
//  Created by Дмитрий  Ванчугов on 22.02.2022.
//

import UIKit

enum Keys: String{
 case photo = "photo"
}

class AddViewController: UIViewController {
    
    private var photoArray: [Photo] = []

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
    }
    
    @IBAction func backButtonPress(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        addPhoto()
    }
    
    @IBAction func addButtonPress(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    
    func addPhoto(){
        guard let image = imageView.image else{ return}
          
        guard let imageName = saveImage(image: image),
          let text = textField.text else {return}
          let photo = Photo(name: imageName, comment: text)
        
        if let array = UserDefaults.standard.value([Photo].self, for: Keys.photo.rawValue){
            var newArray = array
            newArray.append(photo)
            UserDefaults.standard.set(encodable: newArray, for: Keys.photo.rawValue)
        }else {
            let array : [Photo] = [photo]
            UserDefaults.standard.set(encodable: array, for: Keys.photo.rawValue)
        }
        
    }
    
    //Save photo
    func saveImage(image: UIImage) -> String? {
        guard let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        
        let fileName = UUID().uuidString
        let fileUrl = docDir.appendingPathComponent(fileName)
        guard  let data = image.pngData() else {return nil}
        
        if FileManager.default.fileExists(atPath: fileUrl.path){
            do {
                try FileManager.default.removeItem(atPath: fileUrl.path)
                print("remove")
            } catch let eror {
                print("catch", eror)
            }
        }
        
        do{
            try data.write(to: fileUrl)
            return fileName
        }catch let error {
            print("wrong", error)
            return nil
        }
    }
    

}

extension AddViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var chosenImage = UIImage()
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            chosenImage = image
        }else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            chosenImage = image
        }
        
         imageView.image = chosenImage
        
        picker.dismiss(animated: true, completion: nil)
    }
    
}

extension AddViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}



