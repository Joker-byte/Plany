//  UiViewController+.swift
//  Plany
//  Created by Gianluca Dubioso on 26/10/2020.
//  Extension UIView Controller

import UIKit

extension UIViewController {
                //MARK: Custom Nav Button
  func customNavigationButton(selector: Selector? = nil, named: String? = nil, tintColor: UIColor? = nil, dataButton: Data? = nil){
    let mioButton = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
    
    if let namedExist = named {
      mioButton.setImage(UIImage(named: namedExist), for: .normal)
    }
   if let dataExist = dataButton {
    mioButton.setImage(UIImage(data: dataExist, scale: CGFloat(20)), for: .normal)
    mioButton.layer.cornerRadius = mioButton.frame.width*0.6
   }
    if let ciSta = selector {
      mioButton.addTarget(self, action: ciSta, for: .touchUpInside)
    }
    if let cistaColor = tintColor {
      mioButton.imageView?.image = mioButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
      mioButton.imageView?.tintColor = cistaColor
    }
    mioButton.clipsToBounds = true
    mioButton.imageView?.contentMode = .scaleAspectFit
    navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: mioButton)]
  }
  
  //MARK: Label Navigation
  func labelNavigation(textColor: UIColor, text: String){
    let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 32))
    label.numberOfLines = 2
    label.text = text
    label.textColor = textColor
    
    navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: label)]
  }
  //MARK: Function 
  @objc func addTapped () {
    guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "peppe2") as? CalendarViewController  else {
      return
    }
    vc.modalPresentationStyle = .overFullScreen
    navigationController?.pushViewController(vc, animated: true)
  }

  @objc func addTapped2 () {
    guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Profile") as? ProfileViewController  else {
      return
    }
    vc.modalPresentationStyle = .overFullScreen
    navigationController?.pushViewController(vc, animated: true)
  }
  
  
  @objc func addTapped3 () {
    guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Picker") as? PickerViewController  else {
      return
    }
    vc.modalTransitionStyle = .crossDissolve
    navigationController?.present(vc, animated: true)
  }
  
  // MARK: Alert
  func alertPresent(textTitle: String, mexText : String, actTitle: String) {
  
    let alert = UIAlertController(title: textTitle ,
                                  message: mexText,
                                  preferredStyle: .alert)
    
         alert.addAction(UIAlertAction(
                          title: actTitle,
                          style: .cancel,
                          handler: nil))
        present(alert,
                animated: true,
                completion: nil)
  }
  
  
  //MARK: finire change datepicker
//
//  @objc func showDatePicker(){
//     //Formate Date
//      datePicker.datePickerMode = .date
//
//      //ToolBar
//     let toolbar = UIToolbar();
//     toolbar.sizeToFit()

  
  
  
  //MARK: UserDefaults handler
  
//  @objc func Defaultset(data: String? = nil, key: String) {
//    UserDefaults.standard.set(data, forKey: key)
//  }
//  @objc func DefaultObj(key: String){
//    UserDefaults.standard.object(forKey: key)
//  }
//  @objc func DefaultString(key: String){
//    UserDefaults.standard.string(forKey: key)
//  }


}

