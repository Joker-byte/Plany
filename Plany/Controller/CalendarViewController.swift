//  CalendarViewController.swift
//  Plany
//  Created by Gianluca Dubioso on 22/10/2020.

import UIKit

class CalendarViewController: UIViewController {
  
  @IBOutlet weak var titleTextView: UITextField!
  @IBOutlet var tagTextField: UITextField!
  @IBOutlet weak var dateLabel: UILabel!
<<<<<<< HEAD
  
=======
>>>>>>> try
  @IBOutlet weak var datePicker: UIDatePicker!
  @IBOutlet weak var timeLabel: UILabel!
 
  override func viewDidLoad() {
    super.viewDidLoad()
    setView()
  }
}

extension CalendarViewController {
<<<<<<< HEAD
<<<<<<< HEAD
  //MARK: Add Item UserDefaults
=======
  
>>>>>>> try
=======
  //MARK: Add Item UserDefaults
>>>>>>> feature/refactor
  @objc func saveTitleTag() {
    
    if titleTextView.text == "" || tagTextField.text == "" {
         alertPresent(
          textTitle: "Hey Dude",
          mexText: "Text Field can't be Empty",
          actTitle: "Cancel")
         } else {
          guard let titleTx = titleTextView.text,
                let tagTx = tagTextField.text else {
            return
     }
    UserDefaults.standard.set(titleTx, forKey: "TitleText")
    UserDefaults.standard.set(tagTx, forKey: "TagText")
          
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> feature/refactor
  NotificationCenter.default.post(
        name: NSNotification.Name(
          rawValue: "updateArray"),
            object: nil)
<<<<<<< HEAD
=======
        NotificationCenter.default.post(
          name: NSNotification.Name(
            rawValue: "updateArray"),
              object: nil)
>>>>>>> try
=======
>>>>>>> feature/refactor
         }
    
guard let vc = UIStoryboard(
        name: "Main",
        bundle: nil).instantiateViewController(
        withIdentifier: "peppe") as? ViewController  else {
      return
    }
    vc.modalPresentationStyle = .overFullScreen
    navigationController?.popViewController(animated: true)
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
    
    UserDefaults.standard.set(stringDate, forKey: "DateText")
    UserDefaults.standard.set(secondDate, forKey: "DateTime")
    
<<<<<<< HEAD
  }
=======
      }
>>>>>>> try
  
  @objc func setView(){
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .done,
      target: self,
      action: #selector(saveTitleTag))
    
     datePicker.setValue(UIColor.white, forKeyPath: "textColor")
     titleTextView.layer.cornerRadius = 4
     dateLabel.text = "Select Date"
     timeLabel.text = "Select Time"
  }
}
