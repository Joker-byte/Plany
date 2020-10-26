//
//  UiViewController+.swift
//  Plany
//
//  Created by Gianluca Dubioso on 26/10/2020.
//

import UIKit

extension UIViewController {
  func customNavigationButton(selector: Selector? = nil, named: String, tintColor: UIColor? = nil){
    let mioButton = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
    
    mioButton.setImage(UIImage(named: named), for: .normal)
    if let ciSta = selector {
      mioButton.addTarget(self, action: ciSta, for: .touchUpInside)
    }
    // mioButton.tintColor = tintColor
    
    if let cistaColor = tintColor {
      mioButton.imageView?.image = mioButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
      
      mioButton.imageView?.tintColor = cistaColor
    }
    mioButton.imageView?.contentMode = .scaleAspectFit
    
    navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: mioButton)]
  }
  
  func labelNavigation(textColor: UIColor, text: String){
    let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 32))
    label.numberOfLines = 2
    label.text = text
    label.textColor = textColor
    
    navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: label)]
  }
}
  
