//
//  CalendarViewController.swift
//  Plany
//
//  Created by Gianluca Dubioso on 22/10/2020.
//

import UIKit

class CalendarViewController: UIViewController {
  
  @IBOutlet weak var titleTextView: UITextView!
  @IBOutlet weak var tagTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveTitleTag))

  }
  
  @objc func saveTitleTag() {
    let titleTx = titleTextView.text
    let tagTx = tagTextField.text
    
    UserDefaults.standard.set(titleTx, forKey: "TitleText")
    UserDefaults.standard.set(tagTx, forKey: "TagText")
    
    guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "peppe") as? ViewController  else {
      return
    }
    vc.modalPresentationStyle = .overFullScreen
    navigationController?.popViewController(animated: true)
    //navigationController?.pushViewController(vc, animated: true)
  }
  
}
