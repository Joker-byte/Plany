//
//  Profile+.swift
//  Plany
//
//  Created by Gianluca Dubioso on 03/11/2020.
//
import UIKit

extension ProfileViewController {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return
    }
    ProfileImage.image = pickedImage
    
    if let imageURL = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.imageURL.rawValue)] as! URL? {
      UserDefaults.standard.set(imageURL, forKey: "ProfileImage")
      UserDefaults.standard.synchronize()
      
      dismiss(animated: true, completion: nil)
      
    }
  }
  
  func customNavigationButtonSave(selector: Selector? = nil, named: String, tintColor: UIColor? = nil){
    let saveButton = UIButton(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
    
    saveButton.setImage(UIImage(named: named), for: .normal)
    saveButton.frame.size.height = 14
    saveButton.frame.size.width = 14
    
    if let ciSta = selector {
      
      saveButton.addTarget(self, action: ciSta, for: .touchUpInside)
      saveButton.setImage(UIImage.init(named: "SavedIcon"), for: UIControl.State.highlighted)
      saveButton.setImage(UIImage.init(named: "SavedIcon"), for: UIControl.State.selected)
    }
    
    if let cistaColor = tintColor {
      
      saveButton.imageView?.image = saveButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
      saveButton.imageView?.tintColor = cistaColor
      
    }
    saveButton.imageView?.contentMode = .scaleAspectFit
    navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: saveButton)]
  }
  
  @objc func loadingImage(){
    // Load the image
    if let imageURL = UserDefaults.standard.url(forKey: "ProfileImage") {
      if let data = NSData(contentsOf: imageURL) as NSData? {
        self.ProfileImage.image = UIImage(data: data as Data)
      }
    }
  }
  
  @objc func saveNameSurname () {
    guard let name = nameField.text,
          let surname = surnameField.text else {
      return
    }
    
    let resultTextField = name + " " + surname
    NotificationCenter.default.post(name: NSNotification.Name("updateName"), object: resultTextField)
    
    let resulted = "Hello \n" + resultTextField
    UserDefaults.standard.set(resulted, forKey: "User")
    
    saveInfo_clicked()
    
  }
  @objc func saveInfo_clicked() {
    let nome = nameField.text
    let cognome = surnameField.text
    
    UserDefaults.standard.set(nome, forKey: "UserName")
    UserDefaults.standard.set(cognome, forKey: "UserSurname")
    
  }
}

