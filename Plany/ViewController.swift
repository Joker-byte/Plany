//  ViewController.swift
//  Plany
//  Created by Gianluca Dubioso on 22/10/2020.

import UIKit
// collection View
struct CustomData {
  
   
}
// collection

class ViewController: UIViewController {
 
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var addHomeworkButton: UIButton!
  @IBOutlet weak var homeworkLabel: UILabel!
  @IBOutlet weak var tasksLabel: UILabel!
  @IBOutlet weak var calendar: UIImageView!
  @IBOutlet weak var homeworkCollection: UICollectionView!
  @IBOutlet weak var titleText: UILabel!
  @IBOutlet weak var tagText: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var tasksCollection: UICollectionView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setlayout()
    observerItems()
    userDefaultSet()

  }
                              
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    titleText.text = UserDefaults.standard.string(forKey: "TitleText")
    tagText.text = UserDefaults.standard.string(forKey: "TagText")
    dateLabel.text = UserDefaults.standard.string(forKey: "DateText")
    
  }
 func updateSearchResults(for searchController: UISearchController) {
      guard let text = searchController.searchBar.text else { return }
      print(text)
  }
  func setlayout(){
    
    UITextField.appearance(
      whenContainedInInstancesOf: [
        UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    
    tasksCollection.layer.cornerRadius = 5
    homeworkCollection.layer.cornerRadius = 5
//    titleText.text = "Title"
  //  tagText.text = "Text "
//    dateLabel.text = " Date"
    
    navigationItem.backButtonTitle = "Calendar"
    calendar.image = UIImage(named: "CalendarIcon")
  
    addHomeworkButton.frame = CGRect(x: 0, y: 0, width: 12, height: 12)
    addHomeworkButton.setImage(UIImage(named: "Add"), for: .normal)
    addHomeworkButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
    
  }
  
  func observerItems(){
    
    NotificationCenter.default.addObserver(forName: NSNotification.Name("updateName"), object: nil, queue: .main) { (notification) in
      
      guard let nameNotification = notification.object as? String else {
        return
      }
      self.labelNavigation(textColor: .white, text: "Hello \n" + nameNotification)
      self.customNavigationButton(selector: #selector(self.addTapped2), dataButton: UserDefaults.standard.object(forKey: "ProfileImage") as? Data)
    }
  }
  func userDefaultSet(){
    customNavigationButton(selector: #selector(addTapped2), named: "PersonIcon", tintColor: .red, dataButton: UserDefaults.standard.object(forKey: "ProfileImage") as? Data)
    
    labelNavigation(textColor: .white, text: UserDefaults.standard.string(forKey: "User") ?? "Hello \nName Surname")
  }
  
}



