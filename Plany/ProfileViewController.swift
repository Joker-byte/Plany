//
//  ProfileViewController.swift
//  Plany
//
//  Created by Gianluca Dubioso on 27/10/2020.
//

import UIKit

class ProfileViewController: UIViewController {
  
  @IBOutlet weak var ProfileImage: UIImageView!
  
  @IBOutlet weak var nameField: UITextField!
  
  @IBOutlet weak var surnameField: UITextField!
  
  @IBOutlet weak var changeImage: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    ProfileImage.image = UIImage(named: "PersonIcon")
    ProfileImage.layer.cornerRadius = ProfileImage.frame.size.width/2
    // ProfileImage.clipsToBounds = true
    //ProfileImage.contentMode = UIView.ContentMode.scaleAspectFill
    customNavigationButtonSave(selector: #selector(saveNameSurname), named: "SaveIcon", tintColor: .blue)
   
    nameField.text = "My Name"
    surnameField.text = "My Sur"
    
    // Do any additional setup after loading the view.
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
