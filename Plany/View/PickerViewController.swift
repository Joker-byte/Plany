//
//  PickerViewController.swift
//  Plany
//
//  Created by Gianluca Dubioso on 31/01/21.
//

import UIKit

class PickerViewController: UIViewController {
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  
  @IBOutlet weak var datePicker: UIDatePicker!
    
  @IBOutlet var popUp: UIView!
  
  override func viewDidLoad() {
           super.viewDidLoad()
    
    popUp.layer.cornerRadius = 9
    }
  
  
  @IBAction func datePickerChanged(_ sender: Any) {
    let dateFormatter = DateFormatter()
    let timeFormatter = DateFormatter()
    
    dateFormatter.dateStyle = DateFormatter.Style.short
    dateFormatter.timeStyle = DateFormatter.Style.short
     
    dateFormatter.dateFormat = "yyyy-MM-dd"
    timeFormatter.dateFormat = "HH:mm"
    
    let stringDate = dateFormatter.string(from: datePicker.date)
    let secondDate = timeFormatter.string(from: datePicker.date)
      
    dateLabel.text = stringDate
    timeLabel.text = secondDate
    
//    UserDefaults.standard.set(stringDate, forKey: "DateText")
//    UserDefaults.standard.set(secondDate, forKey: "DateTime")
    
//    NotificationCenter.default.post(
//          name: NSNotification.Name(
//            rawValue: "updateArray"),
//              object: nil)
//    
  }
  
  @IBAction func returnOK(_ sender: Any) {
  dismiss(animated: true, completion: nil)
  }
  
  
  @IBAction func returnnil(_ sender: Any) {
    dismiss(animated: true, completion: nil)
    
  }
  
  
}
