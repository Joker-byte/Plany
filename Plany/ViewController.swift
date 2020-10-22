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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        // Do any additional setup after loading the view.
    }
    
    @objc func addTapped () {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "peppe2") as? CalendarViewController  else {
            return
        }
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)
    }
}
