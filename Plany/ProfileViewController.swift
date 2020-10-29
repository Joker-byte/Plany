//
//  ProfileViewController.swift
//  Plany
//
//  Created by Gianluca Dubioso on 27/10/2020.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
  
  @IBOutlet weak var ProfileImage: UIImageView!
  
  @IBOutlet weak var nameField: UITextField!
  
  @IBOutlet weak var surnameField: UITextField!
  
  @IBOutlet weak var changeImage: UIButton!
  
  let imagePicker = UIImagePickerController()
  
  let defaults = UserDefaults.standard
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    ProfileImage.image = UIImage(named: "PersonIcon")
    ProfileImage.layer.cornerRadius = ProfileImage.frame.size.width/2
    // ProfileImage.clipsToBounds = true
    //ProfileImage.contentMode = UIView.ContentMode.scaleAspectFill
    customNavigationButtonSave(selector: #selector(saveNameSurname), named: "SaveIcon", tintColor: .blue)
    
    //    nameField.text = "My Name"
    //    surnameField.text = "My Sur"
    
    nameField.text = defaults.string(forKey: "UserName")
    surnameField.text = defaults.string(forKey: "UserSurname")
    
    ProfileImage.layer.cornerRadius = ProfileImage.frame.size.width/2
    imagePicker.delegate = self
    imagePicker.allowsEditing = true
    
    // Do any additional setup after loading the view.
    
    //    let defaults = UserDefaults.standard
    
    guard let nome = defaults.object(forKey: "UserName") else {
      return
    }
    
    guard let cognome = defaults.object(forKey: "UserSurname") else {
      return
    }
    
    print(nome as! String)
    // nameField.text = nome as? String
    // surnameField.text = cognome as? String
    
    print(cognome as! String)
    
  }
  //override func viewDidDisappear(_ animated: Bool) {
  // super.viewDidDisappear(animated)
  
  @objc func saveNameSurname () {
    guard let name = nameField.text,
          let surname = surnameField.text else {
      return
    }
    
    nameField.text = name
    surnameField.text = surname
    
    let resultTextField = name + " " + surname
    NotificationCenter.default.post(name: NSNotification.Name("updateName"), object: resultTextField)
    
    
    saveInfo_clicked()
    
  }
  
  
  @objc func saveInfo_clicked() {
    guard !self.nameField.text!.isEmpty else {
      return
    }
    
    guard !self.surnameField.text!.isEmpty else {
      return
    }
    
    let nome = self.nameField.text!
    let cognome = self.surnameField.text!
    
    let defaults = UserDefaults.standard
    
    defaults.set(nome, forKey: "UserName")
    defaults.set(cognome, forKey: "UserSurname")
    
  }
  
  
  @IBAction func didTapAddPhotoButton(_ sender: Any) {
    
    let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    
    alert.addAction(UIAlertAction(title: "Photo Gallery", style: .default, handler: { (button) in
      self.imagePicker.sourceType = .photoLibrary
      self.present(self.imagePicker, animated: true, completion: nil)
    }))
    
    alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (button) in
      self.imagePicker.sourceType = .camera
      self.present(self.imagePicker, animated: true, completion: nil)
    }))
    
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    
    present(alert, animated: true, completion: nil)
  }
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
    
    ProfileImage.image = pickedImage
    
    dismiss(animated: true, completion: nil)
  }
}

extension ProfileViewController {
  
  
  
  
  
  
  func customNavigationButtonSave(selector: Selector? = nil, named: String, tintColor: UIColor? = nil){
    let saveButton = UIButton(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
    
    saveButton.setImage(UIImage(named: named), for: .normal)
    saveButton.frame.size.height = 14
    saveButton.frame.size.width = 14
    
    if let ciSta = selector {
      
      saveButton.addTarget(self, action: ciSta, for: .touchUpInside)
      saveButton.setImage(UIImage.init(named: "SavedIcon"), for: UIControl.State.highlighted)//When highlighted
      saveButton.setImage(UIImage.init(named: "SavedIcon"), for: UIControl.State.selected)//When selected
      
    }
    // mioButton.tintColor = tintColor
    
    if let cistaColor = tintColor {
      
      saveButton.imageView?.image = saveButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
      saveButton.imageView?.tintColor = cistaColor
      
    }
    
    saveButton.imageView?.contentMode = .scaleAspectFit
    navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: saveButton)]
  }
  
  //  @objc func onclickDateCheckMark(sender:UIButton) {
  //      if sender.isSelected == true {
  //          sender.isSelected = false
  //          print("not Selected")
  //      }else {
  //          sender.isSelected = true
  //          print("Selected")
  //
  //      }
  //  }
}

//
