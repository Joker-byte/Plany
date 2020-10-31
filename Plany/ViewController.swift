//
//  ViewController.swift
//  Plany
//
//  Created by Gianluca Dubioso on 22/10/2020.
//
import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var addHomeworkButton: UIButton!
  @IBOutlet weak var homeworkLabel: UILabel!
  @IBOutlet weak var tasksLabel: UILabel!
  @IBOutlet weak var calendar: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // il viewdidload viene chiamato solo una volta finche non viene deinizializzata la view
    UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
  
    addHomeworkButton.frame = CGRect(x: 0, y: 0, width: 12, height: 12)
    addHomeworkButton.setImage(UIImage(named: "Add"), for: .normal)
    addHomeworkButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
    customNavigationButton(selector: #selector(addTapped2), named: "PersonIcon", tintColor: .red)
    calendar.image = UIImage(named: "CalendarIcon")
    navigationItem.backButtonTitle = "Calendar"
    
    labelNavigation(textColor: .white, text: UserDefaults.standard.string(forKey: "User") ?? "Hello \nName Surname")

    NotificationCenter.default.addObserver(forName: NSNotification.Name("updateName"), object: nil, queue: .main) { (notification) in
      
      guard let nameNotification = notification.object as? String else {
        return
      }
      self.labelNavigation(textColor: .white, text: "Hello \n" + nameNotification)
    }
  }
 
}
