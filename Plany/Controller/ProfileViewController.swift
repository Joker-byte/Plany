//  ProfileViewController.swift
//  Plany
//  Created by Gianluca Dubioso on 27/10/2020.

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate {
  
  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var nameField: UITextField!
  @IBOutlet weak var surnameField: UITextField!
  @IBOutlet weak var changeImage: UIButton!
  @IBOutlet var profileTable: UITableView!
  
  let imagePicker = UIImagePickerController()
  
  var optionArray : [String] = ["Option1", "Option1", "Option1", "Option1", "Option1"]

  override func viewDidLoad() {
    super.viewDidLoad()
    
    imagePicker.delegate = self
    imagePicker.allowsEditing = true
   
    self.profileTable.delegate = self
    self.profileTable.dataSource = self
   
    controlexistence()
    userDefault()
    setLayout()
  }
}
extension ProfileViewController {
  
 func controlexistence(){
    
    if let existStringName = UserDefaults.standard.string(forKey: "UserName"){
      nameField.text = existStringName
      
    } else {
      nameField.placeholder = "Insert Name"
    }
    
    if let existStringSurname = UserDefaults.standard.string(forKey: "UserSurname"){
      surnameField.text = existStringSurname
      
    } else {
      surnameField.placeholder = "Insert SurnName"
    }
    
    if let existUser = UserDefaults.standard.object(forKey: "ProfileImage") as? Data {
      profileImage.image = UIImage(data: existUser)
    } else {
      profileImage.image = UIImage(named: "PersonIcon")
    }
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return
    }
    profileImage.image = pickedImage
    let pngIcon = pickedImage.pngData()
    UserDefaults.standard.set(pngIcon, forKey: "ProfileImage")
    dismiss(animated: true, completion: nil)
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
  
  func customNavigationButtonSave(selector: Selector? = nil, named: String, tintColor: UIColor? = nil){
    let saveButton = UIButton(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
    saveButton.setImage(UIImage(named: named), for: .normal)
    
    if let ciSta = selector {
      saveButton.addTarget(self, action: ciSta, for: .touchUpInside)
      saveButton.setImage(UIImage.init(named: "SavedIcon"), for: UIControl.State.highlighted)
      saveButton.setImage(UIImage.init(named: "SavedIcon"), for: UIControl.State.selected)
    }
    if let cistaColor = tintColor {
      saveButton.imageView?.tintColor = cistaColor
    }
    saveButton.imageView?.contentMode = .scaleAspectFit
    navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: saveButton)]
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
  
  func setLayout(){
      profileImage.contentMode = .scaleAspectFill
      profileImage.clipsToBounds = true
      profileImage.layer.cornerRadius = profileImage.frame.height/2
     customNavigationButtonSave(selector: #selector(saveNameSurname), named: "SaveIcon", tintColor: .blue)
    
  }
  
  func userDefault(){
      nameField.text = UserDefaults.standard.string(forKey: "UserName")
      surnameField.text = UserDefaults.standard.string(forKey: "UserSurname")
  }
}

extension ProfileViewController : UITableViewDataSource{

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.optionArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = profileTable.dequeueReusableCell(withIdentifier: "optionCell", for: indexPath)
    
    cell.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
    cell.textLabel?.text = optionArray[indexPath.row]
    
    return cell
  }
}
extension ProfileViewController: UITableViewDelegate {
  
}
