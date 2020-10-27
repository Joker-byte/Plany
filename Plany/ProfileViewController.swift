//
//  ProfileViewController.swift
//  Plany
//
//  Created by Gianluca Dubioso on 27/10/2020.
//

import UIKit

class ProfileViewController: UIViewController {

  @IBOutlet weak var ProfileImage: UIImageView!
  
  override func viewDidLoad() {
        super.viewDidLoad()
   
      ProfileImage.image = UIImage(named: "PersonIcon")
      ProfileImage.layer.cornerRadius = ProfileImage.frame.size.width/2
   // ProfileImage.clipsToBounds = true
    //ProfileImage.contentMode = UIView.ContentMode.scaleAspectFill
    
        // Do any additional setup after loading the view.
    }
    
}
