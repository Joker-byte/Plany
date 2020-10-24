//
//  CalendarViewController.swift
//  Plany
//
//  Created by Gianluca Dubioso on 22/10/2020.
//

import UIKit

class CalendarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(addTapped))
        
        // Do any additional setup after loading the view.
    }
    
    @objc func addTapped () {
        navigationController?.popViewController(animated: true)
        // dismiss(animated: true, completion: nil)
    }

   

}
