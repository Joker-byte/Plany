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
    
    let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 32))
    label.numberOfLines = 2
    label.text = "Hello \nName surname"
    label.textColor = .white
    
    navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: label)]
    
    calendar.image = UIImage(named: "CalendarIcon")
    
    
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    
    let mioButton = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
    
    mioButton.setImage(UIImage(named: "PersonIcon"), for: .normal)
    mioButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
    mioButton.tintColor = .black
    mioButton.imageView?.contentMode = .scaleAspectFit
    
    navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: mioButton)]
    navigationItem.backButtonTitle = "Calendar"
    
    addHomeworkButton.frame.size.height = 22
    addHomeworkButton.frame.size.width = 22
    addHomeworkButton.setImage(UIImage(named: "Add"), for: .normal)
    
  }
  
  @objc func addTapped () {
    guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "peppe2") as? CalendarViewController  else {
      return
    }
    vc.modalPresentationStyle = .overFullScreen
    navigationController?.pushViewController(vc, animated: true)
  }
  
  
  @objc func addHomework () {
    print("homework added")
  }
}

extension UIViewController {
  
}


