//
//  UIViewController+.swift
//  Plany
//
//  Created by Gianluca Dubioso on 16/04/25.
//

import UIKit

extension UIViewController {
    
    //UIViewNavigations Components
    //MARK: Custom Nav Button
    
    func customNavigationButton(selector: Selector? = nil, named: String? = nil, tintColor: UIColor? = nil, dataButton: Data? = nil) {
        let mioButton = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        
        
        if let namedExist = named {
            if let image = UIImage(named: namedExist) {
                let resizedImage = image.resized(to: CGSize(width: 32, height: 32))
                //  mioButton.imageView?.contentMode = .scaleAspectFill
                mioButton.setImage(resizedImage, for: .normal)
            }
        }
        
        if let dataExist = dataButton {
            if let image = UIImage(data: dataExist) {
                let resizedImage = image.resized(to: CGSize(width: 32, height: 32))
                mioButton.setImage(resizedImage, for: .normal)
            }
        }
        
        if let ciSta = selector {
            mioButton.addTarget(self, action: ciSta, for: .touchUpInside)
        }
        
        if let cistaColor = tintColor {
            //            mioButton.imageView?.image = mioButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
            mioButton.imageView?.tintColor = cistaColor
            // mioButton.tintColor = cistaColor
        }
        
        mioButton.imageView?.contentMode = .scaleAspectFill
        mioButton.clipsToBounds = true
        //  mioButton.imageView?.contentMode = .scaleAspectFill
        mioButton.layer.cornerRadius = mioButton.frame.height / 2
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

}
