//
//  ViewController.swift
//  Plany
//
//  Created by Gianluca Dubioso on 22/10/2020.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var SearchBar: UISearchBar!
    
    @IBOutlet weak var AddHomeworkButton: UIButton!
    
    @IBOutlet weak var HomeworkLabel: UILabel!
    
    @IBOutlet weak var TasksLabel: UILabel!
    
    @IBOutlet weak var Calendar: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
           
//        let hello: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
//        hello.titleLabel?.numberOfLines = 2
//        hello.setTitle("Hello \nName surname", for: .normal)
//
//        hello.setTitleColor(.black, for: .normal)
//
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 32))
        label.numberOfLines = 2
        label.text = "Hello \nName surname"
        label.textColor = .white
        
        navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: label)]
//        setupNavigation(barTintColor: .white)
//        setupRightButton(target: self, action: #selector(addTapped), imageName: "ProfileImage")
        Calendar.image = UIImage(named: "CalendarIcon")
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        let mioButton = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
       
            mioButton.setImage(UIImage(named: "PersonIcon"), for: .normal)
        
        mioButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        mioButton.tintColor = .black
        mioButton.frame.size.height = 40
        mioButton.frame.size.width = 40
     //   mioButton.contentVerticalAlignment = .fill
   //     mioButton.contentHorizontalAlignment = .fill
        mioButton.imageView?.contentMode = .scaleAspectFit
        
       
      navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: mioButton)]
      
       

        navigationItem.backButtonTitle = "Calendar"
        
        
            AddHomeworkButton.setImage(UIImage(named: "add"), for: .normal)
     
    }
    
    
    @objc func addTapped () {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "peppe2") as? CalendarViewController  else {
            return
        }
        // let rootVc = UINavigationController(rootViewController: vc)
        vc.modalPresentationStyle = .overFullScreen
        navigationController?.pushViewController(vc, animated: true)
        // present(rootVc, animated: true, completion: nil)
    }
    
    
    @objc func addHomework () {
        print("homework added")
    }
}


extension UIViewController {
//    func setupRightButton(target: Any, action: Selector, imageName: String, size: CGSize =  CGSize(width:25, height:22)) {
//       let button = UIButton(type: .custom)
//       let imageButton = UIImage(named: imageName)
//       button.setImage(imageButton, for: UIControl.State.normal)
//       button.imageView?.contentMode = .scaleAspectFit
//       button.addTarget(target, action: action, for: .touchUpInside)
//       button.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
//       button.contentVerticalAlignment = .fill
//       button.contentHorizontalAlignment = .fill
//       let barButton = UIBarButtonItem(customView: button)
//       navigationItem.rightBarButtonItems = [barButton]
        
     }
    
//    func setupNavigation(title: String? = nil, colorTitle: UIColor = .white, fontName: String = "HelveticaNeue-UltraLight", fontSize: CGFloat = 20 ,  barTintColor: UIColor, imageName: String = "") {
//       self.navigationController?.navigationBar.barTintColor = barTintColor
//       self.navigationController?.navigationBar.isTranslucent = false
//       navigationController?.navigationBar.titleTextAttributes = [
//         .font: UIFont(name: fontName, size: fontSize)!,
//         .foregroundColor: colorTitle
//       ]
//       self.navigationItem.title = title
//       if imageName != ""{
//         let logo = UIImage(named: imageName)
//         let imageView = UIImageView(image: logo)
//         self.navigationItem.titleView = imageView
//       }
//     }
//}
