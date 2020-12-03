//  CalendarViewController.swift
//  Plany
//  Created by Gianluca Dubioso on 22/10/2020.

import UIKit

class CalendarViewController: UIViewController {
  
  @IBOutlet weak var titleTextView: UITextView!
  @IBOutlet weak var tagTextField: UITextField!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var datePicker: UIDatePicker!
  
  @IBAction func datePickerChanged(_ sender: Any) {
    let dateFormatter = DateFormatter()
   
    dateFormatter.dateStyle = DateFormatter.Style.medium
    dateFormatter.timeStyle = DateFormatter.Style.short
           
    let stringDate = dateFormatter.string(from: datePicker.date)
      
    dateLabel.text = stringDate
    UserDefaults.standard.set(stringDate, forKey: "DateText")
      }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveTitleTag))
    
     datePicker.setValue(UIColor.white, forKeyPath: "textColor")
     titleTextView.layer.cornerRadius = 4
     dateLabel.text = "Select Date"
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
  }
}
