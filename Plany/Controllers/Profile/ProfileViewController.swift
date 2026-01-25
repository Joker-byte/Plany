    //  ProfileViewController.swift
    //  Plany
    //  Created by Gianluca Dubioso on 27/10/2020.

import UIKit

class ProfileViewController: UIViewController  {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var changeImage: UIButton!
    @IBOutlet var profileTable: UITableView!
    
    let imagePicker = UIImagePickerController()
    
    struct SettingSection {
        let title: String
        let options: [SettingOption]
    }
    
    struct SettingOption {
        let title: String
        let type: OptionType
    }
    
    enum OptionType {
        case themeSelector
        case toggle(key: String)
        case action
    }
    
    var settingSections: [SettingSection] = []
        //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSettings()
        controlexistence()
        
        setLayout()
    }
    
    func setupSettings() {
        if UserDefaults.standard.object(forKey: "animationsEnabled") == nil {
            UserDefaults.standard.set(true, forKey: "animationsEnabled")
        }
        if UserDefaults.standard.object(forKey: "taskReminders") == nil {
            UserDefaults.standard.set(true, forKey: "taskReminders")
        }
        if UserDefaults.standard.object(forKey: "soundEffects") == nil {
            UserDefaults.standard.set(true, forKey: "soundEffects")
        }
        
        settingSections = [
            SettingSection(title: "Appearance", options: [
                SettingOption(title: "Theme", type: .themeSelector),
                SettingOption(title: "Animations", type: .toggle(key: "animationsEnabled"))
            ]),
            SettingSection(title: "Notifications", options: [
                SettingOption(title: "Task Reminders", type: .toggle(key: "taskReminders")),
                SettingOption(title: "Sound Effects", type: .toggle(key: "soundEffects"))
            ]),
            SettingSection(title: "Data & Storage", options: [
                SettingOption(title: "Clear All Tasks", type: .action),
                SettingOption(title: "Clear Profile Data", type: .action)
            ]),
            SettingSection(title: "About", options: [
                SettingOption(title: "App Version", type: .action)
            ])
        ]
    }
    override func viewWillAppear(_ animated: Bool) {
        userDefault()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        self.profileTable.delegate = self
        self.profileTable.dataSource = self
        
    }
}
extension ProfileViewController {
        //MARK: Control Existence
    func controlexistence(){
        
        if let existStringName = UserDefaults.standard.string(
            forKey: "UserName"){
            
            nameField.text = existStringName
            
        } else {
            nameField.placeholder = "Insert Name"
        }
        
        if let existStringSurname = UserDefaults.standard.string(
            forKey: "UserSurname"){
            
            surnameField.text = existStringSurname
            
        } else {
            
            surnameField.placeholder = "Insert SurnName"
            
        }
        
        if let existUser = UserDefaults.standard.object(
            forKey: "ProfileImage") as? Data {
            profileImage.image = UIImage(
                data: existUser)
        } else {
            profileImage.image = UIImage(
                named: "PersonIcon")
            
        }
    }
   
    
    @IBAction func didTapAddPhotoButton(_ sender: Any) {
            //MARK: Alert
        
        let alert = UIAlertController(
            title: nil, message: nil,
            preferredStyle: .actionSheet)
        pickImage(alert: alert, title: "Photo Gallery", sourceType: .photoLibrary)
        pickImage(alert: alert, title: "Camera", sourceType: .camera)
      
        alert.addAction(UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: nil))
        
        present(
            alert, animated: true,
            completion: nil)
    }
    @objc func pickImage(alert:UIAlertController, title: String,
                         sourceType: UIImagePickerController.SourceType
    ) {
        alert.addAction(UIAlertAction(
            title: title,
            style: .default,
            handler: { (button) in
                
                self.imagePicker.sourceType = sourceType
                
                self.present(
                    
                    self.imagePicker,
                    animated: true,
                    completion: nil)
            }
        )
      )
    }
    
        //MARK: Button Save
    func customNavigationButtonSave(
        selector: Selector? = nil,
        named: String,
        tintColor: UIColor? = nil){
            
            let saveButton = UIButton(
                
                frame: CGRect(
                    x: 0, y: 0,
                    width: 28,
                    height: 28))
            
            saveButton.setImage(UIImage(
                named: named),
                                for: .normal)
            
            if let ciSta = selector {
                
                saveButton.addTarget(
                    self, action: ciSta,
                    for: .touchUpInside)
                
                saveButton.setImage(UIImage.init(
                    named: "SavedIcon"),
                                    for: UIControl.State.highlighted)
                
                saveButton.setImage(UIImage.init(
                    named: "SavedIcon"),
                                    for: UIControl.State.selected)
            }
            if let cistaColor = tintColor {
                saveButton.imageView?.tintColor = cistaColor
            }
            saveButton.imageView?.contentMode = .scaleAspectFit
            navigationItem.rightBarButtonItems = [
                UIBarButtonItem(customView: saveButton)]
        }
    
        //MARK: Save Items
    @objc func saveNameSurname () {
        
        guard let name = nameField.text,
              let surname = surnameField.text else {
            return
        }
        
        if name != "" && surname != "" {
            
            
            let resultTextField = name + " " + surname
            
            NotificationCenter.default.post(
                name: NSNotification.Name(
                    "updateName"),
                object: resultTextField)
            
            let resulted = "Hello \n" + resultTextField
            
            UserDefaults.standard.set(
                resulted, forKey: "User")
            
            saveInfo_clicked()
        } else {
            return
        }
    }
    
    @objc func saveInfo_clicked() {
        let nome = nameField.text
        let cognome = surnameField.text
        
        UserDefaults.standard.set(
            nome, forKey: "UserName")
        UserDefaults.standard.set(
            cognome, forKey: "UserSurname")
    }
        //MARK: Layout
    func setLayout(){
        
        profileImage.contentMode = .scaleAspectFill
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        
        customNavigationButtonSave(
            selector: #selector(
                saveNameSurname),
            named: "SaveIcon",
            tintColor: .blue)
    }
    
    func userDefault(){
        nameField.text = UserDefaults.standard.string(
            forKey: "UserName")
        surnameField.text = UserDefaults.standard.string(
            forKey: "UserSurname")
        
    }
}

    //extension ProfileViewController: UITableViewDelegate {
    //
    //}
    //MARK: Table View DataSource
extension ProfileViewController : UITableViewDataSource , UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingSections[section].options.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return settingSections[section].title
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.textColor = .white
            header.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = profileTable.dequeueReusableCell(withIdentifier: "optionCell", for: indexPath)
        let option = settingSections[indexPath.section].options[indexPath.row]
        
        cell.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        cell.textLabel?.text = option.title
        cell.textLabel?.textColor = .white
        cell.selectionStyle = .none
        
        cell.accessoryView = nil
        cell.accessoryType = .none
        
        switch option.type {
        case .themeSelector:
            let segmentControl = UISegmentedControl(items: ["Auto", "Light", "Dark"])
            segmentControl.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "appTheme")
            segmentControl.addTarget(self, action: #selector(themeChanged(_:)), for: .valueChanged)
            segmentControl.tintColor = .white
            if #available(iOS 13.0, *) {
                segmentControl.selectedSegmentTintColor = #colorLiteral(red: 0.173355639, green: 0.1415168047, blue: 0.1407646239, alpha: 1)
            }
            cell.accessoryView = segmentControl
            
        case .toggle(let key):
            let toggle = UISwitch()
            toggle.isOn = UserDefaults.standard.bool(forKey: key)
            toggle.onTintColor = #colorLiteral(red: 0.173355639, green: 0.1415168047, blue: 0.1407646239, alpha: 1)
            toggle.addTarget(self, action: #selector(toggleChanged(_:)), for: .valueChanged)
            toggle.tag = indexPath.section * 100 + indexPath.row
            cell.accessoryView = toggle
            
        case .action:
            if #available(iOS 13.0, *) {
                cell.addCustomDisclosureIndicator(with: .white)
            } else {
                cell.tintColor = .white
                cell.accessoryType = .disclosureIndicator
            }
            
            if option.title == "App Version" {
                cell.detailTextLabel?.text = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
                cell.detailTextLabel?.textColor = .lightGray
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option = settingSections[indexPath.section].options[indexPath.row]
        
        if case .action = option.type {
            if option.title == "Clear All Tasks" {
                showClearDataAlert()
            } else if option.title == "Clear Profile Data" {
                showClearProfileAlert()
            } else if option.title == "App Version" {
                showAboutAlert()
            }
        }
    }
    
    @objc func themeChanged(_ sender: UISegmentedControl) {
        UserDefaults.standard.set(sender.selectedSegmentIndex, forKey: "appTheme")
        applyTheme(sender.selectedSegmentIndex)
        
        let alert = UIAlertController(
            title: "Theme Changed",
            message: "Please restart the app to fully apply the new theme to all custom colors and gradients.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc func toggleChanged(_ sender: UISwitch) {
        let section = sender.tag / 100
        let row = sender.tag % 100
        let option = settingSections[section].options[row]
        
        if case .toggle(let key) = option.type {
            UserDefaults.standard.set(sender.isOn, forKey: key)
        }
    }
    
    func applyTheme(_ theme: Int) {
        if #available(iOS 13.0, *) {
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let window = windowScene?.windows.first
            
            switch theme {
            case 0:
                window?.overrideUserInterfaceStyle = .unspecified
            case 1:
                window?.overrideUserInterfaceStyle = .light
            case 2:
                window?.overrideUserInterfaceStyle = .dark
            default:
                break
            }
        }
    }
    
    func showClearDataAlert() {
        let alert = UIAlertController(
            title: "Clear All Tasks",
            message: "This will delete all tasks and homework. This action cannot be undone.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Delete All", style: .destructive) { _ in
            UserDefaults.standard.removeObject(forKey: "shared")
            UserDefaults.standard.removeObject(forKey: "abitudine")
            UserDefaults.standard.removeObject(forKey: "DateText")
            UserDefaults.standard.removeObject(forKey: "DateTime")
            UserDefaults.standard.removeObject(forKey: "TitleText")
            UserDefaults.standard.removeObject(forKey: "TagText")
            
            NotificationCenter.default.post(name: NSNotification.Name("updateArray"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name("sharedUpdated"), object: nil)
            
            let successAlert = UIAlertController(
                title: "Success",
                message: "All tasks and homework have been cleared. Please go back to see changes.",
                preferredStyle: .alert
            )
            successAlert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(successAlert, animated: true)
        })
        
        present(alert, animated: true)
    }
    
    func showClearProfileAlert() {
        let alert = UIAlertController(
            title: "Clear Profile Data",
            message: "This will reset your name, surname and profile picture. This action cannot be undone.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Reset Profile", style: .destructive) { _ in
            UserDefaults.standard.removeObject(forKey: "UserName")
            UserDefaults.standard.removeObject(forKey: "UserSurname")
            UserDefaults.standard.removeObject(forKey: "User")
            UserDefaults.standard.removeObject(forKey: "ProfileImage")
            
            self.nameField.text = ""
            self.nameField.placeholder = "Insert Name"
            self.surnameField.text = ""
            self.surnameField.placeholder = "Insert SurnName"
            self.profileImage.image = UIImage(named: "PersonIcon")
            
            NotificationCenter.default.post(name: NSNotification.Name("updateName"), object: "Hello\nGuest")
            
            let successAlert = UIAlertController(
                title: "Success",
                message: "Profile data has been reset.",
                preferredStyle: .alert
            )
            successAlert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(successAlert, animated: true)
        })
        
        present(alert, animated: true)
    }
    
    func showAboutAlert() {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        let alert = UIAlertController(
            title: "Plany",
            message: "Version \(version)\n\nA simple and elegant task management app.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}


extension ProfileViewController: UINavigationControllerDelegate{
        //
        //DispatchQueue.main.async {
        //    self.navigationController?.pushViewController(vc, animated: true)
        //    }
        //dispatch_async(dispatch_get_main_queue(), ^{
        //        // your navigation controller action goes here
        //});

}

extension ProfileViewController: UIImagePickerControllerDelegate{

        //MARK: Picker Controller
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [
            UIImagePickerController.InfoKey : Any]) {
                
                guard let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
                else { return }
                profileImage.image = pickedImage
                let pngIcon = pickedImage.pngData()
                
                UserDefaults.standard.set(
                    pngIcon, forKey: "ProfileImage")
                dismiss(animated: true,
                        completion: nil)
            }


}
