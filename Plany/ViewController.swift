//
//  ViewController.swift
//  Plany
//
//  Created by Gianluca Dubioso on 22/10/2020.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var HelloLabel: UILabel!
    
    @IBOutlet weak var NameLabel: UILabel!
    
    
    @IBOutlet weak var ProfileImage: UIImageView!
    
    @IBOutlet weak var SearchBar: UISearchBar!
    
    @IBOutlet weak var AddHomeworkButton: UIButton!
    
    @IBOutlet weak var HomeworkLabel: UILabel!
    
    
    @IBOutlet weak var TasksLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mioButton = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        mioButton.setImage(UIImage(named: ""), for: .normal)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem()
            
   
        // Do any additional setup after loading the view.
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
        let mioButton = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        mioButton.setImage(UIImage(named: ""), for: .normal)
        
    }
}
