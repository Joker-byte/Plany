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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mioButton = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
            mioButton.setImage(UIImage(named: "ProfileImage"), for: .normal)
            mioButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
       
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: mioButton)
        
        let hello: UIButton = UIButton(frame: CGRect(x: 100, y: 400, width: 100, height: 50))
        hello.titleLabel?.numberOfLines = 2
        hello.setTitle("Hello \nName surname", for: .normal)
        
        hello.setTitleColor(.black, for: .normal)
    
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: hello)
        
        
     
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
}


extension UINavigationController {
    func rightButton() {
      //  let mioButton = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
       // mioButton.setImage(UIImage(named: ""), for: .normal)
        
    }
}
