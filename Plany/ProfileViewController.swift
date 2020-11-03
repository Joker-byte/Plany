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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    ProfileImage.image = UIImage(named: "PersonIcon")
    ProfileImage.layer.cornerRadius = ProfileImage.frame.size.width/2
    ProfileImage.layer.cornerRadius = ProfileImage.frame.size.width/2
    
    loadingImage()
    
    imagePicker.delegate = self
    imagePicker.allowsEditing = true
    
    nameField.text = UserDefaults.standard.string(forKey: "UserName")
    surnameField.text = UserDefaults.standard.string(forKey: "UserSurname")
    
    customNavigationButtonSave(selector: #selector(saveNameSurname), named: "SaveIcon", tintColor: .blue)
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
}
